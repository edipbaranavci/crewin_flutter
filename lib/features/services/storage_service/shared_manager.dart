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
}

enum _Eunums { userId }
