import 'package:green_city/core/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static late final SharedPreferences _instance;

  static Future<void> init() async {
    _instance = await SharedPreferences.getInstance();
  }

  static Future setString(String key, String value) async =>
      await _instance.setString(key, value);

  static Future<void> saveTheme(int themeIndex) async =>
      await _instance.setInt(Constants.themeKey, themeIndex);

  static int loadTheme() => _instance.getInt(Constants.themeKey) ?? 0;

  static Future isLogIn(bool value) async =>
      await _instance.setBool(Constants.kIsLogin, value);

  static bool getBool(String key) => _instance.getBool(key) ?? false;

  static String? getString(String key) => _instance.getString(key);

  static Future setToken(String value) async =>
      await _instance.setString(Constants.kToken, value);

  static String? getToken() => _instance.getString(Constants.kToken);

  static Future clear() async => await _instance.clear();

  static Future removeData({required String key}) async =>
      await _instance.remove(key);
}
