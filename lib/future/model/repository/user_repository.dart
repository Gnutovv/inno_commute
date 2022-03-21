import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

import 'package:inno_commute/future/model/entities/user.dart';

class UserRepository {
  final User user;
  bool isAuthorized = false;
  UserRepository(this.user);

  Future<bool> userInit() async {
    final prefs = await SharedPreferences.getInstance();
    user.id = prefs.getString('id') ?? 'null';
    user.login = prefs.getString('login') ?? 'null';
    user.password = prefs.getString('password') ?? 'null';

    if (user.id == 'null') {
      return false;
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.id)
        .get()
        .then((value) {
      if (user.login.toLowerCase() == value.get('up_login') &&
          user.password == value.get('password')) {
        user.alias = prefs.getString('alias') ?? 'null';
        user.name = prefs.getString('name') ?? 'null';
        isAuthorized = true;
        return true;
      }
    });

    return false;
  }

  Future<void> userSave() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('id', user.id);
    prefs.setString('login', user.login);
    prefs.setString('name', user.name);
    prefs.setString('alias', user.alias);
    prefs.setString('password', user.password);
  }

  bool getAuthorizedState() {
    return isAuthorized;
  }

  void deauthorization() {
    user.alias = 'null';
    user.id = 'null';
    user.login = 'null';
    user.password = 'null';
    isAuthorized = false;
    userSave();
  }

// нужно потом доделать!!!!!!!!
  Future<bool> editData(
      {required String userId,
      required String login,
      required String name,
      required String alias,
      required String password}) async {
    var fs = FirebaseFirestore.instance.collection('users');
    var result =
        await fs.where('up_login', isEqualTo: login.toUpperCase()).get();
    if (result.docs.isNotEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> authorizationUser(
      {required String login, required String password}) async {
    user.login = login;
    user.password = md5.convert(utf8.encode(password)).toString();
    var fs = FirebaseFirestore.instance.collection('users');
    var result =
        await fs.where('up_login', isEqualTo: user.login.toUpperCase()).get();
    if (result.docs.isNotEmpty) {
      if (result.docs.first['password'] == user.password) {
        user.alias = result.docs.first['alias'];
        user.id = result.docs.first.id;
        user.name = result.docs.first['name'];
        userSave();
        isAuthorized = true;
        return true;
      }
    }
    return false;
  }

  Future<bool> registerUser(
      {required String login,
      required String name,
      required String alias,
      required String password}) async {
    user.login = login;
    user.name = name;
    user.alias = alias[0] == '@' ? alias : '@$alias';
    user.password = md5.convert(utf8.encode(password)).toString();
    var fs = FirebaseFirestore.instance.collection('users');
    var result =
        await fs.where('up_login', isEqualTo: user.login.toUpperCase()).get();

    if (result.docs.isNotEmpty) {
      return false;
    } else {
      await fs.add({
        'login': user.login,
        'up_login': user.login.toUpperCase(),
        'name': user.name,
        'alias': user.alias,
        'password': user.password
      });
      await fs
          .where('up_login', isEqualTo: user.login.toUpperCase())
          .get()
          .then((value) {
        user.id = value.docs.first.id;
      });
      userSave();
      isAuthorized = true;
      return true;
    }
  }
}
