import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/src/module/app/app_widget.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'src/common/utils/app_environment.dart';
import 'src/common/utils/getit_utils.dart';
import 'src/core/datasources/local/shared_preference/storage.dart';


void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

      await AppEnvironment.setup();
      await AppStorage.setup();
      await GetItUtils.setup();


      //url_launcher
      WidgetsFlutterBinding.ensureInitialized();

      final talker = getIt<Talker>();
      _setupErrorHooks(talker);

      Bloc.observer = TalkerBlocObserver(talker: talker);

      runApp(AppWidget());
    },
    (error, stack) {
      getIt<Talker>().handle(error, stack);
    },
  );
}


Future _setupErrorHooks(Talker talker, {bool catchFlutterErrors = true}) async {
  if (catchFlutterErrors) {
    FlutterError.onError = (FlutterErrorDetails details) async {
      _reportError(details.exception, details.stack, talker);
    };
  }
  PlatformDispatcher.instance.onError = (error, stack) {
    _reportError(error, stack, talker);
    return true;
  };

  /// Web doesn't have Isolate error listener support
  if (!kIsWeb) {
    Isolate.current.addErrorListener(
      RawReceivePort((dynamic pair) async {
        final isolateError = pair as List<dynamic>;
        _reportError(
          isolateError.first.toString(),
          isolateError.last.toString(),
          talker,
        );
      }).sendPort,
    );
  }
}

void _reportError(dynamic error, dynamic stackTrace, Talker talker) async {
  talker.error('Unhandled Exception', error, stackTrace);
}
