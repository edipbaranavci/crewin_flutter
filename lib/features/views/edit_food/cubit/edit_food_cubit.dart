import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/enums/firebase/collections_enums.dart';
import '../../../../core/extensions/scaffold_messenger/snack_bar.dart';
import '../../../models/food/food_model.dart';
import '../../../models/save_user_model.dart';

part 'edit_food_state.dart';

class EditFoodCubit extends Cubit<EditFoodState> {
  EditFoodCubit(this.saveUserModel, this.docId) : super(EditFoodInitial()) {
    _init();
  }
  final SaveUserModel? saveUserModel;

  final String docId;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final foodTitle = TextEditingController();
  final foodDescription = TextEditingController();
  final foodMaterials = TextEditingController();

  final _picker = ImagePicker();

  final String updatedFoodMessage = 'Tarifiniz Güncellendi!';
  final String imageCouldntSelectedMessage = 'Resim Seçilemedi!';

  void _init() {
    _setDocumentReference();
    _setValues();
  }

  Future<void> updateFood() async {
    await state.documentReference?.update({
      'description': foodDescription.text,
      'materials': foodMaterials.text,
      'title': foodTitle.text,
      'time': Timestamp.now().seconds,
    });
    scaffoldKey.showGreatSnackBar(updatedFoodMessage);
    emit(state.copyWith(isUpdated: true));
  }

  Future<void> pickImage() async {
    final result = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );

    if (result != null) {
      if (state.imageUrl is String) {
        FirebaseStorage.instance.refFromURL(state.imageUrl ?? '').delete();
        state.documentReference?.update(state.foodModel
                ?.copyWith(imageUrl: await _uploadImage(File(result.path)))
                .toJson() ??
            {});
      }
      emit(state.copyWith(file: File(result.path)));
    } else {
      scaffoldKey.showErrorSnackBar(imageCouldntSelectedMessage);
    }
  }

  Future<String?> _uploadImage(File file) async {
    String? imageUrl;
    final imagesRef = FirebaseStorage.instance.ref().child(
        'images/${saveUserModel?.userId ?? ''}/${Timestamp.now().seconds.toString()}');
    await imagesRef.putFile(file);
    imageUrl = await imagesRef.getDownloadURL();
    return imageUrl;
  }

  void _setValues() {
    state.documentReference?.get().then((value) {
      final model = FoodModel.fromJson(value.data() ?? {});
      emit(state.copyWith(foodModel: model));
      foodTitle.text = model.title ?? '';
      foodMaterials.text = model.materials ?? '';
      foodDescription.text = model.description ?? '';
      if (model.imageUrl is String) {
        emit(state.copyWith(imageUrl: model.imageUrl));
      }
    });
  }

  void _setDocumentReference() {
    emit(state.copyWith(
        documentReference: FirebaseFirestore.instance
            .collection(CollectionEnums.foods.name)
            .doc(saveUserModel?.userId ?? '')
            .collection(CollectionEnums.foods.name)
            .doc(docId)));
  }
}
