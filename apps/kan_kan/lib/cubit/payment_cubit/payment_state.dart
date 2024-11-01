part of 'payment_cubit.dart';

@immutable
sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class SuccessPaymentState extends PaymentState {}

final class ErrorPaymentState extends PaymentState {}

final class LoadingPaymentState extends PaymentState {}
