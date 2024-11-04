part of 'splash_cubit.dart';

@immutable
sealed class SplashState {}

final class SplashInitial extends SplashState {}

final class SuccessState extends SplashState {}

final class LoadingState extends SplashState {}

final class ErrorState extends SplashState {
  final String errorMessage;
  ErrorState({required this.errorMessage});
}
