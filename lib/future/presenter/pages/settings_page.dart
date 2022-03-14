import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SettingsPageIsNotAuthorized();
  }
}

class SettingsPageIsAuthorized extends StatelessWidget {
  const SettingsPageIsAuthorized({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SettingsPageIsNotAuthorized extends StatelessWidget {
  const SettingsPageIsNotAuthorized({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
