// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:learning/src/common/theme/default_text_theme.dart' as _i535;
import 'package:learning/src/common/utils/logger.dart' as _i132;
import 'package:learning/src/core/datasources/remote/module/api_module.dart'
    as _i389;
import 'package:talker_flutter/talker_flutter.dart' as _i207;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final loggerModule = _$LoggerModule();
    final apiModule = _$ApiModule();
    gh.singleton<_i535.DefaultTextTheme>(() => _i535.DefaultTextTheme());
    gh.singleton<_i207.Talker>(() => loggerModule.talker());
    gh.factory<String>(
      () => apiModule.apiUrl,
      instanceName: 'apiUrl',
    );
    gh.singleton<_i361.Dio>(
      () => apiModule.dio(
        gh<String>(instanceName: 'apiUrl'),
        gh<_i207.Talker>(),
      ),
      instanceName: 'dio',
    );
    return this;
  }
}

class _$LoggerModule extends _i132.LoggerModule {}

class _$ApiModule extends _i389.ApiModule {}
