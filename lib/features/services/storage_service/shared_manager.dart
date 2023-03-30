import 'package:shared_preferences/shared_preferences.dart';

class SharedManager {
  Future<bool> setSaveUserId(String id) async {
    final pref = await SharedPreferences.getInstance();
    return await pref.setString(_Eunums.userId.name, id);
  }

  Future<String?> getSaveUserId() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(_Eunums.userId.name);
  }

  Future<bool> removeSaveUserId() async {
    final pref = await SharedPreferences.getInstance();
    if (pref.containsKey(_Eunums.userId.name)) {
      return await pref.remove(_Eunums.userId.name);
    }
    return false;
  }
}

enum _Eunums { userId }
