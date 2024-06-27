import 'package:shared_preferences/shared_preferences.dart';

class CacheNetwork {
  static late SharedPreferences sharedpref;
  static Future chacheInitialization() async {
    sharedpref = await SharedPreferences.getInstance();
  }

  static Future<bool> insertToCache(
      {required String key, required String value}) async {
    return await sharedpref.setString(key, value);
  }

  static Future<String?> getCacheData({required String key}) async {
    return sharedpref.getString(key);
 }
  static Future<bool> deleteCacheData({required String key}) async {
    return await sharedpref.remove(key);
  }
}
