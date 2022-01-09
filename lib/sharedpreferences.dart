import 'package:shared_preferences/shared_preferences.dart';

class PreferenceShared {
  static SharedPreferences? pref;

  Future<void> initPref() async {
    pref = await SharedPreferences.getInstance();
  }

  setSkey(String key, String value) {
    pref!.setString(key, value);
  }

  getSket(String key) {
    return pref!.getString(key);
  }

  setBkey(String key, bool value) {
    pref!.setBool(key, value);
  }

  getBkey(String key) {
    return pref!.getBool(key);
  }
}
