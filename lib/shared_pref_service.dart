import 'package:shared_preferences/shared_preferences.dart';

class AppService {
  // function of initializing shared pref
  static Future<SharedPreferences> _getPreferences() async {
    // create an instance of SharedPref
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  // variables for keys
  static const String stringValueKey = "stringValueKey";
  static const String themeValueKey = "themeValueKey";

  // set a value
  static Future<bool> storeStringValue({required String newValue}) async {
    try {
      // get the instance
      final prefs = await _getPreferences();

      // storing string value
      bool isValueSet = await prefs.setString(stringValueKey, newValue);

      return isValueSet;
    } catch (e) {
      return false;
    }
  }

  // set a theme value
  static Future<bool> storeThemeValue({required bool newValue}) async {
    try {
      // get the instance
      final prefs = await _getPreferences();

      // storing boolean value
      bool isValueSet = await prefs.setBool(themeValueKey, newValue);

      return isValueSet;
    } catch (e) {
      return false;
    }
  }

  static Future<String?> getStringValue() async {
    try {
      // get instance
      final prefs = await _getPreferences();

      // get String value
      String? stringValue = prefs.getString(stringValueKey);

      // return value
      return stringValue;
    } catch (e) {
      return null;
    }
  }

  static Future<bool?> getThemeValue() async {
    try {
      // get instance
      final prefs = await _getPreferences();

      // get Bool value
      bool? boolValue = prefs.getBool(themeValueKey);

      // return value
      return boolValue;
    } catch (e) {
      return null;
    }
  }
}

// {
//   "key": "value"
// }
