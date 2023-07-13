import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  static const String _onBordingCompelete = 'onBordingCompelete';

  static final AppStorage instance = AppStorage._();

  AppStorage._();

  factory AppStorage() {
    return instance;
  }

  Future<bool> getOnBordingCompelete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onBordingCompelete) ?? false;
  }

  Future<void> setOnBordingCompelete(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onBordingCompelete, value);
  }
}
