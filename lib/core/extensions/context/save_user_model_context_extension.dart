import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/main_cubit.dart';
import '../../../features/models/save_user_model.dart';

extension SaveUserModelContextExtension on BuildContext {
  SaveUserModel? get getSaveUserModel => read<MainCubit>().state.saveUserModel;
}
