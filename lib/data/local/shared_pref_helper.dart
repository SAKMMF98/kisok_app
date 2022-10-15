import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static const String _userIDPrefKey = 'user_id_pref_key';
  static const String _authTokenPrefKey = 'auth_token_pref_key';
  static const String _onBoardingPrefKey = 'onBoardingSeen';
  static const String _stayLoggedInPrefKey = 'stay_logged_in_key';
  static const String _emailPrefKey = 'email_key';

  SharedPrefHelper._();

  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  ///userid
  static String? get userId {
    return _prefs.getString(_userIDPrefKey);
  }

  static set userId(String? value) {
    if (value != null) {
      _prefs.setString(_userIDPrefKey, value);
    } else {
      _prefs.remove(_userIDPrefKey);
    }
  }

  ///isLogged in
  static bool get isLoggedIn {
    return userId != null;
  }

  ///onBoardingShown
  static bool get onBoardingShown {
    return _prefs.getBool(_onBoardingPrefKey) ?? false;
  }

  static set onBoardingShown(bool value) {
    _prefs.setBool(_onBoardingPrefKey, value);
  }

  ///auth token
  static String get authToken {
    return _prefs.getString(_authTokenPrefKey) ?? "";
  }

  static set authToken(String value) {
    _prefs.setString(_authTokenPrefKey, value);
  }

  ///stay logged in
  static bool get stayLoggedIn {
    return _prefs.getBool(_stayLoggedInPrefKey) ?? false;
  }

  static set stayLoggedIn(bool value) {
    _prefs.setBool(_stayLoggedInPrefKey, value);
  }

  ///auth token
  static String get email {
    return _prefs.getString(_emailPrefKey) ?? "";
  }

  static set email(String value) {
    _prefs.setString(_emailPrefKey, value);
  }
}
