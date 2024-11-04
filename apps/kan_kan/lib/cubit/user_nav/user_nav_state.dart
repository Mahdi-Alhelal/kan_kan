part of 'user_nav_cubit.dart';

@immutable
sealed class UserNavState {}

final class UserNavInitial extends UserNavState {}

final class LoadingNavState extends UserNavState {}

final class SuccessNavState extends UserNavState {}



