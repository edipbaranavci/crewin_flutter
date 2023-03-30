import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'edit_food_state.dart';

class EditFoodCubit extends Cubit<EditFoodState> {
  EditFoodCubit() : super(EditFoodInitial());
}
