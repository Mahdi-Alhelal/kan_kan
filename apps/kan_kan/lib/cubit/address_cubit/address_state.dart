part of 'address_cubit.dart';

@immutable
sealed class AddressState {}

final class AddressInitial extends AddressState {}

final class SuccessAddressState extends AddressState {}

final class LoadingAddressState extends AddressState {}

final class ErrorAddressState extends AddressState {}
