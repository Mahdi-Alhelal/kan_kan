part of 'deal_cubit.dart';

@immutable
sealed class DealState {}

final class DealInitial extends DealState {}

final class SuccessSate extends DealState {}

final class ErrorState extends DealState {
  final String errorMessage;
  ErrorState({required this.errorMessage});
}
