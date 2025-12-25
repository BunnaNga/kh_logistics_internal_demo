import 'package:kh_logistics_internal_demo/util/constrain.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  Future<void> setToken(SharedPreferences prefs, String token) async {
    await prefs.setString(Constrain.TOKEN, token);
  }

  Future<void> clearToken(SharedPreferences prefs) async {
    await prefs.remove(Constrain.TOKEN);
  }

  // pref for language
  Future<void> setLanguage(SharedPreferences prefs, String language) async {
    await prefs.setString(Constrain.LANGUAGE, language);
  }

  Future<String> getLanguage(SharedPreferences prefs) async {
    return prefs.getString(Constrain.LANGUAGE).toString();
  }

  Future<void> clearLanguage(SharedPreferences prefs) async {
    await prefs.remove(Constrain.LANGUAGE);
  }
}
