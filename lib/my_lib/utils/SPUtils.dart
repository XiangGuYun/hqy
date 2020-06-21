import 'package:shared_preferences/shared_preferences.dart';

class SPUtils {
  static putString(String key, String value) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences sp = await _prefs;
    sp.setString(key, value);
  }

  static getString(String key, Function getValue) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((v){
      return getValue(v.getString(key));
    });
  }
}
