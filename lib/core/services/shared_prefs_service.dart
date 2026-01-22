import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static late SharedPreferences sharedPrefs;
  static void initSharedPrefs() async {
    sharedPrefs = await SharedPreferences.getInstance();
  }

  static void setBool({required String key, required bool value}) async {
    sharedPrefs.setBool(key, value);
  }

  static bool getBool({required String key}) {
    return sharedPrefs.getBool(key) ?? false;
  }

  static void setData({required String key, required String value}) {
    sharedPrefs.setString(key, value);
  }

  static String getData({required String key}) {
    return sharedPrefs.getString(key) ?? "";
  }
}
