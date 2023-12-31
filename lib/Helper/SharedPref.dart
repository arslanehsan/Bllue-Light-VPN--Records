import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static late SharedPreferencesHelper _instance;
  static late SharedPreferences _preferences;

  // Private constructor
  SharedPreferencesHelper._();

  // Getter for instance
  static Future<SharedPreferencesHelper> getInstance() async {
    if (_instance == null) {
      _instance = SharedPreferencesHelper._();
      await _instance._initPreferences();
    }
    return _instance;
  }

  // Initialize the SharedPreferences instance
  Future<void> _initPreferences() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Get a string value from SharedPreferences
  String getString(String key, {required String defaultValue}) {
    return _preferences.getString(key) ?? defaultValue;
  }

  // Save a string value to SharedPreferences
  void setString(String key, String value) {
    _preferences.setString(key, value);
  }

  // Get an int value from SharedPreferences
  int getInt(String key, {required int defaultValue}) {
    return _preferences.getInt(key) ?? defaultValue;
  }

  // Save an int value to SharedPreferences
  void setInt(String key, int value) {
    _preferences.setInt(key, value);
  }

  // Get a double value from SharedPreferences
  double getDouble(String key, {required double defaultValue}) {
    return _preferences.getDouble(key) ?? defaultValue;
  }

  // Save a double value to SharedPreferences
  void setDouble(String key, double value) {
    _preferences.setDouble(key, value);
  }

  // Get a bool value from SharedPreferences
  bool getBool(String key, {required bool defaultValue}) {
    return _preferences.getBool(key) ?? defaultValue;
  }

  // Save a bool value to SharedPreferences
  void setBool(String key, bool value) {
    _preferences.setBool(key, value);
  }

  // Remove a value from SharedPreferences
  void remove(String key) {
    _preferences.remove(key);
  }

  // Clear all values in SharedPreferences
  void clear() {
    _preferences.clear();
  }
}
