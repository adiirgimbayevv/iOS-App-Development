import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'models.dart';

class AuthStorage {
  static const _usersKey = 'registered_users_json';
  static const _legacyUsersKey = 'registered_users';
  static const _sessionUserKey = 'session_user_json';
  static const _sessionEmailKey = 'session_email';

  Future<SharedPreferences> _prefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    return prefs;
  }

  Future<List<AppUser>> getUsers() async {
    final prefs = await _prefs();

    final jsonBlob = prefs.getString(_usersKey);
    if (jsonBlob != null && jsonBlob.isNotEmpty) {
      final decoded = jsonDecode(jsonBlob);
      if (decoded is List) {
        return decoded
            .map((item) => AppUser.fromJson(Map<String, dynamic>.from(item as Map)))
            .toList();
      }
    }


    final legacy = prefs.getStringList(_legacyUsersKey) ?? [];
    if (legacy.isEmpty) return [];

    final users = legacy
        .map((item) => AppUser.fromJson(jsonDecode(item) as Map<String, dynamic>))
        .toList();
    await _saveUsers(users);
    await prefs.remove(_legacyUsersKey);
    return users;
  }

  Future<AppUser?> getCurrentUser() async {
    final prefs = await _prefs();

    final sessionJson = prefs.getString(_sessionUserKey);
    if (sessionJson != null && sessionJson.isNotEmpty) {
      try {
        return AppUser.fromJson(
          jsonDecode(sessionJson) as Map<String, dynamic>,
        );
      } catch (_) {
   
      }
    }

    final sessionEmail = prefs.getString(_sessionEmailKey);
    if (sessionEmail == null || sessionEmail.isEmpty) return null;

    final users = await getUsers();
    for (final user in users) {
      if (user.email.toLowerCase() == sessionEmail.toLowerCase()) {
        await _setSession(user);
        return user;
      }
    }

    await logout();
    return null;
  }

  Future<String?> register(AppUser user) async {
    final users = await getUsers();
    final exists = users.any(
      (u) => u.email.toLowerCase() == user.email.toLowerCase(),
    );
    if (exists) {
      return 'An account with this email already exists. Please log in.';
    }

    users.add(user);
    await _saveUsers(users);
    await _setSession(user);
    return null;
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    final users = await getUsers();
    AppUser? found;
    for (final user in users) {
      if (user.email.toLowerCase() == email.trim().toLowerCase()) {
        found = user;
        break;
      }
    }

    if (found == null) {
      return 'No account found with this email. Please register first.';
    }
    if (found.password != password) {
      return 'Incorrect password.';
    }

    await _setSession(found);
    return null;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_sessionUserKey);
    await prefs.remove(_sessionEmailKey);
  }

  Future<void> _setSession(AppUser user) async {
    final prefs = await SharedPreferences.getInstance();
    final okUser = await prefs.setString(
      _sessionUserKey,
      jsonEncode(user.toJson()),
    );
    final okEmail = await prefs.setString(_sessionEmailKey, user.email);
    if (!okUser || !okEmail) {
      throw StateError('Failed to persist session');
    }
  }

  Future<void> _saveUsers(List<AppUser> users) async {
    final prefs = await SharedPreferences.getInstance();
    final payload = jsonEncode(users.map((u) => u.toJson()).toList());
    final ok = await prefs.setString(_usersKey, payload);
    if (!ok) {
      throw StateError('Failed to persist users');
    }
  }
}
