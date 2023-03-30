import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/enums/firebase/collections_enums.dart';
import '../../../../core/extensions/scaffold_messenger/snack_bar.dart';
import '../../../models/save_user_model.dart';

part 'add_food_state.dart';

class AddFoodCubit extends Cubit<AddFoodState> {
  AddFoodCubit(this.saveUserModel) : super(AddFoodInitial());
  final SaveUserModel? saveUserModel;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final foodTitle = TextEditingController();
  final foodDescription = TextEditingController();
  final foodMaterials = TextEditingController();

  String? get userId => saveUserModel?.userId;

  final collection =
      FirebaseFirestore.instance.collection(CollectionEnums.foods.name);

  final _picker = ImagePicker();

  final String addedFoodMessage = 'Yeni Tarifiniz Eklendi!';
  final String imageCouldntSelectedMessage = 'Resim Seçilemedi!';

  Future<String?> _uploadImage() async {
    String? imageUrl;
    if (state.file != null) {
      final imagesRef = FirebaseStorage.instance.ref().child(
          'images/${saveUserModel?.userId ?? ''}/${Timestamp.now().seconds.toString()}');
      await imagesRef.putFile(state.file!);
      imageUrl = await imagesRef.getDownloadURL();
      return imageUrl;
    }
    return imageUrl;
  }

  Future<void> addFood() async {
    scaffoldKey.showLoadingBar();

    if (userId != null) {
      Map<String, dynamic> map = {};
      final imageUrl = await _uploadImage();
      map.addAll({
        'time': Timestamp.now().seconds,
        'title': foodTitle.text,
        'materials': foodMaterials.text,
        'description': foodDescription.text,
        'imageUrl': imageUrl,
      });
      if (imageUrl == null) {
        map.remove('imageUrl');
      }
      collection
          .doc(userId)
          .collection(CollectionEnums.foods.name)
          .add(map)
          .whenComplete(() => scaffoldKey.showGreatSnackBar(addedFoodMessage));
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(isAdded: true));
    }
  }

  Future<void> pickImage() async {
    final result = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );

    if (result != null) {
      emit(state.copyWith(file: File(result.path)));
    } else {
      scaffoldKey.showErrorSnackBar(imageCouldntSelectedMessage);
    }
  }
}
