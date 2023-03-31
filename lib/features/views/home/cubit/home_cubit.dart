import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/enums/firebase/collections_enums.dart';
import '../../../../core/extensions/scaffold_messenger/snack_bar.dart';
import '../../../models/save_user_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.saveUserModel) : super(HomeInitial()) {
    _init();
  }

  final SaveUserModel? saveUserModel;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final String deletedRecipeMessage = 'Yemek Tarifi Silindi!';

  Future<void> _init() async {
    await _setSnapshot();
  }

  Future<void> deleteRecipe(String docId) async {
    final doc = await FirebaseFirestore.instance
        .collection(CollectionEnums.foods.name)
        .doc(saveUserModel?.userId)
        .collection(CollectionEnums.foods.name)
        .doc(docId)
        .get();
    try {
      await FirebaseStorage.instance.refFromURL(doc.get('imageUrl')).delete();
      await doc.reference.delete();
      scaffoldKey.showGreatSnackBar(deletedRecipeMessage);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _setSnapshot() async {
    if (saveUserModel?.userId != null) {
      emit(state.copyWith(
        stream: FirebaseFirestore.instance
            .collection(CollectionEnums.foods.name)
            .doc(saveUserModel?.userId)
            .collection(CollectionEnums.foods.name)
            .orderBy('time')
            .snapshots(),
      ));
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }
}
