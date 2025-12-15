import 'package:url_launcher/url_launcher.dart';

import '../constants/url_constant.dart';

void launchAppUrl(String path) async {
  final Uri params = Uri(
    scheme: AppUrlConstant.scheme,
    host: AppUrlConstant.hostUrl,
    path: path,
  );
  if (!await launchUrl(params, mode: LaunchMode.inAppWebView)) {
    throw 'Could not launch $params';
  }
}