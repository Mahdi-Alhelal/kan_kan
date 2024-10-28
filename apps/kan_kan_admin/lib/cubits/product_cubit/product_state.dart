part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class AddProductSuccessState extends ProductState {}

final class ErrorState extends ProductState {
  final String errorMessage;
  ErrorState({required this.errorMessage});
}
