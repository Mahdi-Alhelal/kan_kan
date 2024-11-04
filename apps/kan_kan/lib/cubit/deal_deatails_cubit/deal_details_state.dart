part of 'deal_details_cubit.dart';

@immutable
sealed class DealDetailsState {}

final class DealDetailsInitial extends DealDetailsState {}

final class SuccessIncreaseState extends DealDetailsState {}

final class SuccessDecreaseState extends DealDetailsState {}

final class ErrorState extends DealDetailsState {}

final class LoadingState extends DealDetailsState {}