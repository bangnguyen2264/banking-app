import 'package:bankingapp/services/auth_service.dart';
import 'package:bankingapp/utils/app_preferences.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> initDI() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.put<SharedPreferences>(sharedPreferences, permanent: true);
  Get.put<FlutterSecureStorage>(const FlutterSecureStorage(), permanent: true);

  // App Preferences
  Get.put<AppPreferences>(
    AppPreferences(),
    permanent: true,
  );

  Get.put<AuthService>(
    AuthService(),
    permanent: true,
  );
}
