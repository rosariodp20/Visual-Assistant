import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesInstance {

  static final SharedPreferencesInstance _instance = SharedPreferencesInstance._privateConstructor();

  factory SharedPreferencesInstance() {
    return _instance;
  }

  late SharedPreferences instance;

  SharedPreferencesInstance._privateConstructor() {
    SharedPreferences.getInstance().then((prefs) {
      instance = prefs;
    });
  }
}