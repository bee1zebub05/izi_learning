import 'package:dio/dio.dart';

import '../../local/shared_preference/storage.dart';

class AuthInterceptor extends QueuedInterceptorsWrapper {
  AuthInterceptor();

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await AppStorage.accessToken;
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    return super.onRequest(options, handler);
  }
}
