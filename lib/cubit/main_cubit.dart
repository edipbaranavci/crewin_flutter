import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/constants/enums/firebase/collections_enums.dart';
import '../features/models/save_user_model.dart';
import '../features/services/network_service/auth/firebase_auth_service.dart';
import '../features/services/storage_service/shared_manager.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial()) {
    _init();
  }

  final _collection =
      FirebaseFirestore.instance.collection(CollectionEnums.users.name);

  final _sharedManager = SharedManager();
  final _firebaseAuthService = FirebaseAuthService();

  Future<void> _init() async {
    await _setSaveUserModel();
  }

  Future<void> _setSaveUserModel() async {
    final userId = await _sharedManager.getSaveUserId();
    if (userId is String) {
      final model = SaveUserModel(userId: userId);
      emit(state.copyWith(saveUserModel: model));
      log(userId);
      return;
    } else {
      await loginUser();
    }
  }

  Future<void> loginUser() async {
    final userId = await _firebaseAuthService.loginFirebase();
    if (userId != null) {
      _collection.doc(userId).set({
        'userId': userId,
        'creatTime': Timestamp.now().seconds,
      }).whenComplete(() async {
        _sharedManager.setSaveUserId(userId);
        await _init();
      });
    }
  }
}
