part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class SuccessUserState extends UserState {}

final class LoadingUserState extends UserState {}

final class ErrorUserState extends UserState {
  final String errorMessage;
  ErrorUserState({required this.errorMessage});
}

final class SuccessSortState extends UserState {}
