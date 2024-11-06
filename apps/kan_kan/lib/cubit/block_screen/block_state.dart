part of 'block_cubit.dart';

@immutable
sealed class BlockState {}

final class BlockInitial extends BlockState {}
final class LogoutSuccess extends BlockState {}
