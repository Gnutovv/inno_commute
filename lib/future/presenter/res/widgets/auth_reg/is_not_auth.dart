import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inno_commute/future/model/cubit/user_cubit.dart';
import 'package:inno_commute/future/presenter/res/widgets/auth_reg/reg_dialog.dart';

class SettingsPageIsNotAuthorized extends StatelessWidget {
  const SettingsPageIsNotAuthorized({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _loginController = TextEditingController();
    var _passController = TextEditingController();
    return SizedBox(
      width: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Авторизация'),
          const SizedBox(
            height: 32,
          ),
          TextField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                    gapPadding: 2, borderSide: BorderSide(color: Colors.teal)),
                labelText: 'Логин',
                prefixIcon: Icon(
                  Icons.person_sharp,
                  color: Colors.cyan,
                ),
                suffixStyle: TextStyle(color: Colors.green)),
            controller: _loginController,
          ),
          const SizedBox(
            height: 28,
          ),
          TextField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                    gapPadding: 2, borderSide: BorderSide(color: Colors.teal)),
                labelText: 'Пароль',
                prefixIcon: Icon(
                  Icons.key_sharp,
                  color: Colors.cyan,
                ),
                suffixStyle: TextStyle(color: Colors.green)),
            controller: _passController,
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Авторизоваться'),
            style: ElevatedButton.styleFrom(
              primary: Colors.cyan,
            ),
          ),
          const SizedBox(height: 32),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<UserCubit>(context),
                    child: const RegistrationDialog(),
                  ),
                ),
              );
            },
            child: const Text('Нет аккаунта? Регистрация.'),
          ),
        ],
      ),
    );
  }
}
