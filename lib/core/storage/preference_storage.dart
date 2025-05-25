import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';

import '../basic_features.dart';
import '../environment_setup/environment.dart';
import 'cache_manager.dart';

class PreferenceStorage {
  static final GetStorage _storage = GetStorage();
  static final FlutterSecureStorage _secureStorage =
      const FlutterSecureStorage();

  // Device Support Biometric
  static bool getIsBiometricSupported() =>
      _storage.read<bool>("isBiometricSupported") ?? false;

  static Future<bool?> setIsBiometricSupported(bool value) async {
    try {
      await _storage.write("isBiometricSupported", value);
      return true;
    } catch (error) {
      return null;
    }
  }

  // App Auth Enabled
  static bool getIsBiometricAuthEnabled() {
    final ok = _storage.read<bool>("isAuthBioMetricEnabled") ?? false;
    return ok;
  }

  // make a method to toggle isAuthEnabled
  static Future<bool?> toggleIsBiometricAuthEnabled() async {
    try {
      final current = getIsBiometricAuthEnabled();
      await _storage.write("isAuthBioMetricEnabled", !current);
      return true;
    } catch (error) {
      return null;
    }
  }

  // Login Status
  static Future<void> setLoginStatus(bool value) async {
    try {
      await _secureStorage.write(
          key: '_loginStatusKey', value: value.toString());
    } catch (error) {
      debugPrint('setLoginStatus Error: ${error.toString()}');
    }
  }

  static Future<bool> getLoginStatus() async {
    try {
      String? value = await _secureStorage.read(key: '_loginStatusKey');
      return value?.toLowerCase() == 'true';
    } catch (error) {
      debugPrint('getLoginStatus Error: ${error.toString()}');
      return false;
    }
  }

  static Future<bool?> setShowWelcomeScreen(bool value) async {
    try {
      await _storage.write("showWelcomeScreen", value);
      return true;
    } catch (error) {
      return null;
    }
  }

  // Current AppLocale
  static String getAppLocale() => _storage.read<String>("AppLocale") ?? "";

  static Future<bool?> setAppLocale(String value) async {
    try {
      await _storage.write("AppLocale", value);
      return true;
    } catch (error) {
      return null;
    }
  }

  // Current Latitude
  static String getCurrentLatitude() =>
      _storage.read<String>("CurrentLatitude") ?? "0.0";

  static Future<bool?> setCurrentLatitude(String value) async {
    try {
      await _storage.write("CurrentLatitude", value);
      return true;
    } catch (error) {
      return null;
    }
  }

  // Current Longitude
  static String getCurrentLongitude() =>
      _storage.read<String>("CurrentLongitude") ?? "0.0";

  static Future<bool?> setCurrentLongitude(String value) async {
    try {
      await _storage.write("CurrentLongitude", value);
      return true;
    } catch (error) {
      return null;
    }
  }

  // For FCM token
  static Future<void> setFcmToken(String? value) async {
    try {
      await _secureStorage.write(key: "FcmToken", value: value ?? '');
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  static Future<String?> getFcmToken() async {
    try {
      return await _secureStorage.read(key: "FcmToken") ?? '';
    } catch (error) {
      debugPrint(error.toString());
      return null;
    }
  }

  // For Auth Refresh Token
  static Future<void> setAuthRefreshToken(String? value) async {
    try {
      await _secureStorage.write(key: "AuthRefreshToken", value: value ?? '');
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  static Future<String?> getAuthRefreshToken() async {
    try {
      return await _secureStorage.read(key: "AuthRefreshToken") ?? '';
    } catch (error) {
      debugPrint(error.toString());
      return null;
    }
  }

  // For Auth Access Token
  static Future<void> setAuthAccessToken(String? value) async {
    try {
      await _secureStorage.write(key: "AuthAccessToken", value: value ?? '');
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  static Future<String?> getAuthAccessToken() async {
    try {
      return await _secureStorage.read(key: "AuthAccessToken") ?? '';
    } catch (error) {
      debugPrint(error.toString());
      return null;
    }
  }

  // For String
  static void setString(String key, String value) => _storage.write(key, value);

  static String? getString(String key) => _storage.read<String>(key);

  // For int
  static void setInt(String key, int value) => _storage.write(key, value);

  static int? getInt(String key) => _storage.read<int>(key);

  // For double
  static void setDouble(String key, double value) => _storage.write(key, value);

  static double? getDouble(String key) => _storage.read<double>(key);

  // For bool
  static void setBool(String key, bool value) => _storage.write(key, value);

  static bool getBool(String key) => _storage.read<bool>(key) ?? false;

  // For object
  static Future<bool?>? putObject(String key, Object value) async {
    try {
      await _storage.write(key, jsonEncode(value));
      return true;
    } catch (error) {
      debugPrint(error.toString());
      return null;
    }
  }

  static Future<Object?>? getObject(String key) async {
    try {
      String? json = _storage.read<String>(key);
      if (json == null) {
        return null;
      }
      return jsonDecode(json);
    } catch (error) {
      debugPrint(error.toString());
      return null;
    }
  }

  /// To Get Models

  // To Get Sign In Response Model
  // static SignInResponseModel? getSignInResponseModel() {
  //   String? data = _storage.read(AppString.signInResponseModelKey);
  //   return (data == null || data.isEmpty)
  //       ? null
  //       : SignInResponseModel.fromJson(jsonDecode(data));
  // }

  static bool hasData(String key) => _storage.hasData(key);

  // To Remove Particular Key
  static void removeValue(String key) => _storage.remove(key);

  // To Clear All Prefs
  static Future<void> clearStorage() async {
    // Temporary stop for Preference Values which need to stay even after clearing all Preferences
    final buildMode =
        PreferenceStorage.getString(AppString.currentBuildModeKey) ??
            Environment.development;

    final locale = getAppLocale();

    final isBiometricSupported = getIsBiometricSupported();

    await _storage.erase();
    await _secureStorage.deleteAll();
    await APICacheManager.clearAll();

    // Putting Value Back
    PreferenceStorage.setAppLocale(locale);
    PreferenceStorage.setString(AppString.currentBuildModeKey, buildMode);
    PreferenceStorage.setIsBiometricSupported(isBiometricSupported);
  }
}
