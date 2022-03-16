part of 'user_cubit.dart';

@immutable
abstract class UserState {
  final UserRepository repository;
  const UserState(this.repository);
}

class UserInitial extends UserState {
  const UserInitial(UserRepository repository) : super(repository);
}
