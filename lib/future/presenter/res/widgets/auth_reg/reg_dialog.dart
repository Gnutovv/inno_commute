import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inno_commute/future/model/cubit/user_cubit.dart';

class RegistrationDialog extends StatelessWidget {
  const RegistrationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.cyan,
        title: const Text('Регистрация'),
      ),
      body: Center(
        child: Text(
          BlocProvider.of<UserCubit>(context).state.repository.user.login,
        ),
      ),
    );
  }
}
