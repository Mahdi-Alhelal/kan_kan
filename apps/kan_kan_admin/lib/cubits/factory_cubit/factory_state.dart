part of 'factory_cubit.dart';

@immutable
sealed class FactoryState {}

final class FactoryInitial extends FactoryState {}

final class SuccessState extends FactoryState {}

final class SuccessSupabase extends FactoryState {
  final String message;
  SuccessSupabase({required this.message});
}

final class ErrorState extends FactoryState {
  final String errorMessage;
  ErrorState({required this.errorMessage});
}
