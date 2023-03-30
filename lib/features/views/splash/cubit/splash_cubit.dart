import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial()) {
    _init();
  }

  Future<void> _init() async {
    await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(isLoaded: true));
  }
}
