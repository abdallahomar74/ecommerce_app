import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/shared/constans/constans.dart';
import 'package:flutter/material.dart';


part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  void initSplash() {
    Future.delayed(const Duration(seconds: 3), () {
      if (token != null && token != "") {
        emit(SplashNavigateToLayout());
      } else {
        emit(SplashNavigateToLogin());
      }
    });
    emit(SplashInitState());
  }
}
