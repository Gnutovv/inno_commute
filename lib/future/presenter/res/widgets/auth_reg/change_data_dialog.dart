import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inno_commute/future/model/cubit/user_cubit.dart';

class ChangeDataDialog extends StatelessWidget {
  const ChangeDataDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, TextEditingController> _controllers = {
      'login': TextEditingController(),
      'password': TextEditingController(),
      'alias': TextEditingController(),
      'name': TextEditingController()
    };

    _controllers['login']!.text =
        context.read<UserCubit>().state.repository.user.login;
    _controllers['name']!.text =
        context.read<UserCubit>().state.repository.user.name;
    _controllers['alias']!.text =
        context.read<UserCubit>().state.repository.user.alias;
    _controllers['password']!.text =
        context.read<UserCubit>().state.repository.user.password;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.cyan,
        title: const Text('Изменить данные'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Редактировать данные',
            style: TextStyle(fontSize: 24, color: Colors.cyan),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      gapPadding: 2,
                      borderSide: BorderSide(color: Colors.teal)),
                  labelText: 'Логин',
                  prefixIcon: Icon(
                    Icons.login,
                    color: Colors.cyan,
                  ),
                  suffixStyle: TextStyle(color: Colors.green)),
              controller: _controllers['login'],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      gapPadding: 2,
                      borderSide: BorderSide(color: Colors.teal)),
                  labelText: 'Имя',
                  prefixIcon: Icon(
                    Icons.person_sharp,
                    color: Colors.cyan,
                  ),
                  suffixStyle: TextStyle(color: Colors.green)),
              controller: _controllers['name'],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      gapPadding: 2,
                      borderSide: BorderSide(color: Colors.teal)),
                  labelText: 'Telegram',
                  prefixIcon: Icon(
                    Icons.alternate_email_rounded,
                    color: Colors.cyan,
                  ),
                  suffixStyle: TextStyle(color: Colors.green)),
              controller: _controllers['alias'],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: TextField(
              obscureText: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      gapPadding: 2,
                      borderSide: BorderSide(color: Colors.teal)),
                  labelText: 'Пароль',
                  prefixIcon: Icon(
                    Icons.key,
                    color: Colors.cyan,
                  ),
                  suffixStyle: TextStyle(color: Colors.green)),
              controller: _controllers['password'],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
              if (_controllers['login']!.text.isNotEmpty &&
                  _controllers['name']!.text.isNotEmpty &&
                  _controllers['alias']!.text.isNotEmpty &&
                  _controllers['password']!.text.isNotEmpty) {
                context
                    .read<UserCubit>()
                    .state
                    .repository
                    .editData(
                        userId:
                            context.read<UserCubit>().state.repository.user.id,
                        login: _controllers['login']!.text,
                        name: _controllers['name']!.text,
                        alias: _controllers['alias']!.text,
                        password: _controllers['password']!.text ==
                                context
                                    .read<UserCubit>()
                                    .state
                                    .repository
                                    .user
                                    .password
                            ? null
                            : _controllers['password']!.text)
                    .then((value) => value
                        ? ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                            duration: Duration(seconds: 2),
                            content: Text('Данные изменены'),
                          ))
                        : ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                            duration: Duration(seconds: 2),
                            content: Text(
                                'Такой пользователь уже существует, смените логин'),
                          )));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  duration: Duration(seconds: 2),
                  content: Text('Заполнены не все данные'),
                ));
              }
            },
            child: const Text('Изменить'),
            style: ElevatedButton.styleFrom(
              primary: Colors.cyan,
            ),
          ),
        ],
      ),
    );
  }
}
