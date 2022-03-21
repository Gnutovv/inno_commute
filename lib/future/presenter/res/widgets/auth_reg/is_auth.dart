import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inno_commute/future/model/cubit/user_cubit.dart';
import 'package:inno_commute/future/presenter/res/widgets/auth_reg/change_data_dialog.dart';

class SettingsPageIsAuthorized extends StatelessWidget {
  const SettingsPageIsAuthorized({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(64),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        const Text(
          'Настройки',
          style: TextStyle(fontSize: 32, color: Colors.cyan),
        ),
        Container(
          height: 256,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.cyan),
              borderRadius: BorderRadius.all(Radius.circular(18))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Логин:'),
                  Text(context.read<UserCubit>().state.repository.user.login),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Отображаемое имя:'),
                  Text(context.read<UserCubit>().state.repository.user.name),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Алиас Telegram:'),
                  Text(context.read<UserCubit>().state.repository.user.alias),
                ],
              ),
              TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: BlocProvider.of<UserCubit>(context),
                          child: const ChangeDataDialog(),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit_note_rounded),
                  label: const Text('Изменить данные')),
            ],
          ),
        ),
        ElevatedButton(
            onPressed: () {
              context.read<UserCubit>().userDeauth();
            },
            child: const Text('Выйти из аккаунта')),
      ]),
    );
  }
}
