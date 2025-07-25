import 'package:green_city/core/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static late final SharedPreferences _instance;

  static Future<void> init() async {
    _instance = await SharedPreferences.getInstance();
  }

  static Future setString(String key, String value) async =>
      await _instance.setString(key, value);
  static Future isSub(bool value) async =>
      await _instance.setBool(Constants.kIsSub, value);

  static Future<void> saveTheme(int themeIndex) async =>
      await _instance.setInt(Constants.themeKey, themeIndex);

  static int loadTheme() => _instance.getInt(Constants.themeKey) ?? 0;

  static String? getString(String key) => _instance.getString(key);

  static bool? getSubState() => _instance.getBool(Constants.kIsSub);

  static Future clear() async => await _instance.clear();
}
