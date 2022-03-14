import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthorizationPage extends StatelessWidget {
  const AuthorizationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: Colors.cyan,
          centerTitle: true,
          title: const Text('widget.title'),
        ),
        body: const Center(
          child: Text('Authorization Page'),
        ),
      ),
    );
  }
}
