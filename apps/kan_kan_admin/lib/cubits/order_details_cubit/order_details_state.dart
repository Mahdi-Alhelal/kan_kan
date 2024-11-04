part of 'order_details_cubit.dart';

@immutable
sealed class OrderDetailsState {}

final class OrderDetailsInitial extends OrderDetailsState {}

final class SuccessState extends OrderDetailsState {}

final class ErrorState extends OrderDetailsState {
  final String errorMessage;
  ErrorState({required this.errorMessage});
}
