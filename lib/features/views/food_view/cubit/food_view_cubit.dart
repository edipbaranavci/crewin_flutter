import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/extensions/scaffold_messenger/snack_bar.dart';
import '../../../models/save_user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/enums/firebase/collections_enums.dart';

part 'food_view_state.dart';

class FoodViewCubit extends Cubit<FoodViewState> {
  FoodViewCubit(this.saveUserModel, this.docId) : super(FoodViewInitial());

  final SaveUserModel? saveUserModel;
  final String docId;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final String deletedRecipeMessage = 'Yemek Tarifi Silindi!';

  Future<void> deleteRecipe() async {
    try {
      await FirebaseFirestore.instance
          .collection(CollectionEnums.foods.name)
          .doc(saveUserModel?.userId)
          .collection(CollectionEnums.foods.name)
          .doc(docId)
          .delete();
      scaffoldKey.showGreatSnackBar(deletedRecipeMessage);
      emit(state.copyWith(isDeleted: true));
    } catch (e) {
      print(e);
    }
  }
}
