import 'package:bloc/bloc.dart';
import 'package:inno_commute/future/model/entities/user.dart';
import 'package:inno_commute/future/model/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial(UserRepository(User())));

  void userInit() {
    state.repository.userInit();
  }
}
