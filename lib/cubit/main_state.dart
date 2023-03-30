part of 'main_cubit.dart';

class MainState extends Equatable {
  const MainState({this.saveUserModel});

  final SaveUserModel? saveUserModel;

  @override
  List<Object> get props => [
        saveUserModel ?? SaveUserModel,
      ];

  MainState copyWith({
    SaveUserModel? saveUserModel,
  }) {
    return MainState(
      saveUserModel: saveUserModel ?? this.saveUserModel,
    );
  }
}

class MainInitial extends MainState {}
