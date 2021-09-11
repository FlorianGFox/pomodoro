// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i4;

import '../core/notifications.dart' as _i3;
import '../core/preferences_service.dart' as _i5;
import '../logic/settings_logic/settings_cubit.dart' as _i7;
import '../logic/timer_logic/timer_cubit.dart' as _i6;
import 'service_modules.dart' as _i8; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final serviceModules = _$ServiceModules();
  gh.singleton<_i3.Notifications>(_i3.Notifications());
  await gh.factoryAsync<_i4.SharedPreferences>(() => serviceModules.prefs,
      preResolve: true);
  gh.lazySingleton<_i5.StorageService>(
      () => _i5.StorageService(get<_i4.SharedPreferences>()));
  gh.factory<_i6.TimerCubit>(() => _i6.TimerCubit(get<_i5.StorageService>()));
  gh.factory<_i7.SettingsCubit>(
      () => _i7.SettingsCubit(get<_i5.StorageService>()));
  return get;
}

class _$ServiceModules extends _i8.ServiceModules {}
