import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesCustom {

  static setStringCustom(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static getStringCustom(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

}