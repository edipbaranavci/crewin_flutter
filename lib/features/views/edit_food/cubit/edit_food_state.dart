// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'edit_food_cubit.dart';

class EditFoodState extends Equatable {
  const EditFoodState({
    this.file,
    this.documentReference,
    this.isUpdated = false,
    this.imageUrl,
    this.foodModel,
  });

  final File? file;
  final DocumentReference<Map<String, dynamic>>? documentReference;
  final bool isUpdated;
  final String? imageUrl;
  final FoodModel? foodModel;

  @override
  List<Object> get props => [
        file ?? File,
        documentReference ?? '',
        isUpdated,
        imageUrl ?? '',
        foodModel ?? FoodModel,
      ];

  EditFoodState copyWith({
    File? file,
    DocumentReference<Map<String, dynamic>>? documentReference,
    bool? isUpdated,
    String? imageUrl,
    FoodModel? foodModel,
  }) {
    return EditFoodState(
      file: file ?? this.file,
      documentReference: documentReference ?? this.documentReference,
      isUpdated: isUpdated ?? this.isUpdated,
      imageUrl: imageUrl ?? this.imageUrl,
      foodModel: foodModel ?? this.foodModel,
    );
  }
}

class EditFoodInitial extends EditFoodState {}
