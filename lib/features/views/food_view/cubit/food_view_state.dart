part of 'food_view_cubit.dart';

class FoodViewState extends Equatable {
  const FoodViewState({this.isDeleted = false});

  final bool isDeleted;

  @override
  List<Object> get props => [isDeleted];

  FoodViewState copyWith({
    bool? isDeleted,
  }) {
    return FoodViewState(
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}

class FoodViewInitial extends FoodViewState {}
