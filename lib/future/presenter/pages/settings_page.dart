import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inno_commute/future/model/cubit/user_cubit.dart';
import 'package:inno_commute/future/presenter/res/widgets/auth_reg/is_auth.dart';
import 'package:inno_commute/future/presenter/res/widgets/auth_reg/is_not_auth.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return context.read<UserCubit>().state.repository.isAuthorized()
            ? const SettingsPageIsAuthorized()
            : const SettingsPageIsNotAuthorized();
      },
    );
  }
}
