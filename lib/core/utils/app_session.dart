import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String _keyUserLoggedIn = 'user_logged_in';
  static const String _keyUserName = 'user_name';
  static const String _keyUserEmail = 'user_email';
  static const String _keyFirstLaunch = 'firstLaunch';

  // Save the first launch state
  Future<void> setFirstLaunch(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyFirstLaunch, value);
  }

  // Retrieve the first launch state
  Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyFirstLaunch) ?? true; // Default: true (first launch)
  }

  // Save user login status and data
  Future<void> saveUserSession({
    required String userName,
    required String userEmail,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_keyUserLoggedIn, true);
    prefs.setString(_keyUserName, userName);
    prefs.setString(_keyUserEmail, userEmail);
  }

  // Get the current login status
  Future<bool> isUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyUserLoggedIn) ?? false;
  }

  // Get user data
  Future<Map<String, String?>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString(_keyUserName) ?? '';
    String userEmail = prefs.getString(_keyUserEmail) ?? '';
    return {'userName': userName, 'userEmail': userEmail};
  }

  // Log out and clear session data
  Future<void> logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_keyUserLoggedIn);
    prefs.remove(_keyUserName);
    prefs.remove(_keyUserEmail);
  }
}
