import 'package:shared_preferences/shared_preferences.dart';

class StorageUtils {
  static void set(String key, String value) async {
    var sp = await SharedPreferences.getInstance();
    sp.setString(key, value);
  }

  static void remove(String key) async {
    var sp = await SharedPreferences.getInstance();
    sp.setString(key, null);
  }

  static Future<String> get(String key) async {
    var sp = await SharedPreferences.getInstance();
    return sp.getString(key);
  }
}
