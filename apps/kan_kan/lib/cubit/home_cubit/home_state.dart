part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class LoadingHomeState extends HomeState {}

final class SuccessHomeState extends HomeState {}

final class ErrorHomeState extends HomeState {}
