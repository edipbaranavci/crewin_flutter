part of 'add_food_cubit.dart';

class AddFoodState extends Equatable {
  const AddFoodState({this.file, this.isAdded = false});

  final File? file;

  final bool isAdded;

  @override
  List<Object> get props => [file ?? File, isAdded];

  AddFoodState copyWith({
    File? file,
    bool? isAdded,
  }) {
    return AddFoodState(
      file: file ?? this.file,
      isAdded: isAdded ?? this.isAdded,
    );
  }
}

class AddFoodInitial extends AddFoodState {}
