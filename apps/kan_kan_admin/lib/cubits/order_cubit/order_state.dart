part of 'order_cubit.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}

final class LoadingOrderState extends OrderState {}

final class SuccessOrderState extends OrderState {}

final class ErrorOrderState extends OrderState {
  final String errorMessage;
  ErrorOrderState({required this.errorMessage});
}

final class SortSuccessState extends OrderState {}
