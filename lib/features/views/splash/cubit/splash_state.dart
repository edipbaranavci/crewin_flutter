part of 'splash_cubit.dart';

class SplashState extends Equatable {
  const SplashState({this.isLoaded = false});

  final bool isLoaded;

  @override
  List<Object> get props => [isLoaded];

  SplashState copyWith({
    bool? isLoaded,
  }) {
    return SplashState(
      isLoaded: isLoaded ?? this.isLoaded,
    );
  }
}

class SplashInitial extends SplashState {}
