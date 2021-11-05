import 'package:shared_preferences/shared_preferences.dart';

class PrefsUser {
  static final PrefsUser _instancia =
      PrefsUser._internal();

  factory PrefsUser() {
    return _instancia;
  }

  PrefsUser._internal();

  late SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool get authValue {
    return _prefs.getBool('auth') ?? false;
  }

  set authValue(bool value) {
    _prefs.setBool('auth', value);
  }


  String get userid {
    return _prefs.getString('userid') ?? '';
  }

  set userid(String value) {
    _prefs.setString('userid', value);
  }
}
