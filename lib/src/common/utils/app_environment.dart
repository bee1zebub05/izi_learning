import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnvironment {
  static setup() async {
    await dotenv.load(fileName: ".env");
  }

  static final apiUrl = dotenv.env['API_URL'] ?? '';

  static final fileChannel = dotenv.env['FILE_CHANNEL'] ?? '';
  static final iapChannel = dotenv.env['IAP_CHANNEL'] ?? '';
  static final iapPremiumProductId = dotenv.env['IAP_PREMIUM_PRODUCT_ID'] ?? '';

  static final itunesSharedSecret = dotenv.env['ITUNES_SHARED_SECRET'] ?? '';

  static final appStoreId = dotenv.env['APP_STORE_ID'] ?? '';
  static final playStoreId = dotenv.env['PLAY_STORE_ID'] ?? '';
}
