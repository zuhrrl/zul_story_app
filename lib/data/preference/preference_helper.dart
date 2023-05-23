import 'package:shared_preferences/shared_preferences.dart';
import 'package:zul_story_app/constant/app_constant.dart';

class PreferenceHelper {
  static PreferenceHelper? _preferenceHelper;

  PreferenceHelper._internal() {
    _preferenceHelper = this;
  }

  factory PreferenceHelper() =>
      _preferenceHelper ?? PreferenceHelper._internal();

  saveString(key, value) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  getString(key) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  saveAccessToken(token) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(AUTH_TOKEN_KEY, token);
  }

  getAccessToken() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(AUTH_TOKEN_KEY);
  }
}
