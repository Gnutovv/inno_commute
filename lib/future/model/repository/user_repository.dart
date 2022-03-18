import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inno_commute/future/model/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  final User user;
  UserRepository(this.user);

  Future<bool> userInit() async {
    final prefs = await SharedPreferences.getInstance();
    user.id = prefs.getString('id') ?? 'null';
    user.login = prefs.getString('login') ?? 'null';
    user.password = prefs.getString('password') ?? 'null';

    if (user.id == 'null' || user.login == 'null' || user.password == 'null') {
      return false;
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.id)
        .get()
        .then((value) {
      if (user.login == value.get('login') &&
          user.password == value.get('password')) {
        user.alias = prefs.getString('alias') ?? 'null';
        user.name = prefs.getString('name') ?? 'null';
        user.isAuthorized = true;
        return true;
      }
    });

    return false;
  }

  bool isAuthorized() {
    return user.isAuthorized;
  }
}
