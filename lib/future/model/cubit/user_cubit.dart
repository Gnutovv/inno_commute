import 'package:bloc/bloc.dart';
import 'package:inno_commute/future/model/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(UserState initialState) : super(initialState);
}
