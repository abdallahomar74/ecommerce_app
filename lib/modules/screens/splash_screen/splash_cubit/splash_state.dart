part of 'splash_cubit.dart';

@immutable
sealed class SplashState {}

final class SplashInitial extends SplashState {}
final class SplashInitState extends SplashState {}
final class SplashNavigateToLayout extends SplashState {}
final class SplashNavigateToLogin extends SplashState {}