part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoadLoading extends UserState {}

final class UserloadSuccess extends UserState {
  final User user;

  UserloadSuccess({required this.user});
}

final class UserUpdateLoading extends UserState {}

final class UserUpdateSuccess extends UserState {
  final User user;

  UserUpdateSuccess({required this.user});
}
