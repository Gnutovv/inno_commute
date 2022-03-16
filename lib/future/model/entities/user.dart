import 'package:shared_preferences/shared_preferences.dart';

class User {
  int? id;
  bool? active;
  bool? isAuthorized;
  String? phoneNumber;
  String? alias;
  String? name;
  String? login;
  String? password;

  void userInit() async {
    final prefs = await SharedPreferences.getInstance();
    id = prefs.getInt('id');
    if (id != null) {
      login = prefs.getString('login');
      password = prefs.getString('password');
    }
  }
}
