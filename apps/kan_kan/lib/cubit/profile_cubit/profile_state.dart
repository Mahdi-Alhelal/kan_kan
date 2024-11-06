part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class SuccessProfileState extends ProfileState {}

final class LoadingProfileState extends ProfileState {}

final class ErrorProfileState extends ProfileState {}
final class LogOutSuccess extends ProfileState {}


final class SuccessUpdateProfileState extends ProfileState {}
