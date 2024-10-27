part of 'navigation_cubit.dart';

@immutable
sealed class NavigationState {}

final class NavigationInitial extends NavigationState {}

final class NavigationToNewPage extends NavigationState {}

final class ErrorState extends NavigationState {
  final String errorMessage;
  ErrorState({required this.errorMessage});
}
final class SuccessState extends NavigationState {}
