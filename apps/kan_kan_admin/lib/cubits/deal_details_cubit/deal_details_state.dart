part of 'deal_details_cubit.dart';

@immutable
sealed class DealDetailsState {}

final class DealDetailsInitial extends DealDetailsState {}

final class UpdateDealSuccessState extends DealDetailsState {}

final class UpdateDealStatusSuccessState extends DealDetailsState {}
final class UpdateOrderStatusSuccessState extends DealDetailsState {}

final class ErrorStatus extends DealDetailsState {
  final String errorMessage;
  ErrorStatus({required this.errorMessage});
}
