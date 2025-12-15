
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';

import '../../../../common/extension/optional_x.dart';

class AppStorageKeys {
  static const accessToken = 'access_token';
  static const refreshToken = 'refresh_token';
  static const lang = 'lang';

  static const isPremium = 'is_premium';

  static const isFirstTimeOpenApp = 'is_first_time_open_app';
  static const isSecondTimeOpenApp = 'is_second_time_open_app';

  static const successCount = 'success_count';
}

class AppStorage {
  static late final SharedPreferences _prefs;
  static late final RxSharedPreferences _rxPrefs;

  static const _storage = FlutterSecureStorage();

  static setup() async {
    _prefs = await SharedPreferences.getInstance();

    /// A shared preference wrapper providing [Stream] for listening updates from shared preference by key
    _rxPrefs = RxSharedPreferences(
      _prefs,
      kReleaseMode ? null : const RxSharedPreferencesDefaultLogger(),
    );
  }

  static T? _get<T>(String key) => _prefs.get(key).asOrNull<T>();

  /// set [notify] as 'true' if you want the updated value to be notified for stream subscriptions
  static Future<void> _set<T>(String key, T? val, {bool notify = false}) {
    if (val is bool) {
      return notify ? _rxPrefs.setBool(key, val) : _prefs.setBool(key, val);
    }
    if (val is double) {
      return notify ? _rxPrefs.setDouble(key, val) : _prefs.setDouble(key, val);
    }
    if (val is int) {
      return notify ? _rxPrefs.setInt(key, val) : _prefs.setInt(key, val);
    }
    if (val is String) {
      return notify ? _rxPrefs.setString(key, val) : _prefs.setString(key, val);
    }
    if (val is List<String>) {
      return notify
          ? _rxPrefs.setStringList(key, val)
          : _prefs.setStringList(key, val);
    }
    throw Exception('Type not supported!');
  }

  static RxSharedPreferences get rxPrefs => _rxPrefs;

  static Future<String?> _getSecure(String key) => _storage.read(key: key);

  static Future<void> _setSecure(String key, String? val) =>
      _storage.write(key: key, value: val);

  static String? get lang => _get(AppStorageKeys.lang);

  static Future setLang(String? val) => _set(AppStorageKeys.lang, val);


  static Future<String?> get accessToken =>
      _getSecure(AppStorageKeys.accessToken);

  static Future setAccessToken(String? val) =>
      _setSecure(AppStorageKeys.accessToken, val);

  static Future<String?> get refreshToken =>
      _getSecure(AppStorageKeys.refreshToken);
  static Future setRefreshToken(String? val) =>
      _setSecure(AppStorageKeys.refreshToken, val);

  static bool get isPremium => _get(AppStorageKeys.isPremium) ?? false;
  static Future setPremium(bool? val) => _set(AppStorageKeys.isPremium, val, notify: true);

  static bool get isFirstTimeOpenApp => _get(AppStorageKeys.isFirstTimeOpenApp) ?? true;
  static Future setFirstTimeOpenApp(bool? val) => _set(AppStorageKeys.isFirstTimeOpenApp, val);

  static int get isSecondTimeOpenApp => _get(AppStorageKeys.isSecondTimeOpenApp) ?? 1;
  static Future setSecondTimeOpenApp(int? val) => _set(AppStorageKeys.isSecondTimeOpenApp, val);

  static int get successCount => _get(AppStorageKeys.successCount) ?? 0;
  static Future setSuccessCount(int? val) => _set(AppStorageKeys.successCount, val);
}
