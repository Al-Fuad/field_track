import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static const String _key = "token";

  Future<void> saveToken(String token) async {
    final res = await SharedPreferences.getInstance();
    await res.setString(_key, token);
  }

  Future<String?> getToken() async {
    final res = await SharedPreferences.getInstance();
    return res.getString(_key);
  }

  Future<void> removeToken() async {
    final res = await SharedPreferences.getInstance();
    await res.remove(_key);
  }
}