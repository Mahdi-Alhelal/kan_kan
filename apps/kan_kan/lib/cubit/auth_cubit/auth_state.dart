part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoadingAuthState extends AuthState {}

final class SuccessAuthState extends AuthState {}

final class UserBlocked extends AuthState {}

final class ErrorAuthState extends AuthState {
  final String msg;
  ErrorAuthState({required this.msg});
}
final class LoginAuthState extends AuthState {}
