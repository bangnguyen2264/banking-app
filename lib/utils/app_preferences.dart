import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppPreferences {
  final SharedPreferences _prefs = Get.find<SharedPreferences>();
  final FlutterSecureStorage _secureStorage = Get.find<FlutterSecureStorage>();

  /// Lưu dữ liệu vào SharedPreferences
  Future<void> saveToPrefs(String key, String value) async {
    await _prefs.setString(key, value);
  }

  /// Lấy dữ liệu từ SharedPreferences
  String? getFromPrefs(String key) {
    return _prefs.getString(key);
  }

  /// Lưu dữ liệu vào Secure Storage
  Future<void> saveToSecureStorage(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  /// Lấy dữ liệu từ Secure Storage
  Future<String?> getFromSecureStorage(String key) async {
    return await _secureStorage.read(key: key);
  }

  /// Xóa dữ liệu
  Future<void> removeKey(String key) async {
    await _prefs.remove(key);
    await _secureStorage.delete(key: key);
  }

  /// Kiểm tra xem một key có tồn tại trong SharedPreferences không
  bool containsKeyInPrefs(String key) {
    return _prefs.containsKey(key);
  }

  /// Kiểm tra xem một key có tồn tại trong Secure Storage không
  Future<bool> containsKeyInSecureStorage(String key) async {
    return (await _secureStorage.read(key: key)) != null;
  }

  /// Xóa tất cả dữ liệu
  Future<void> clearAll() async {
    await _secureStorage.deleteAll();
  }
}
