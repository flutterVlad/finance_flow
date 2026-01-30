part of 'settings_bloc.dart';

@freezed
abstract class SettingsEvent with _$SettingsEvent {
  const factory SettingsEvent.init() = InitSettingsEvent;

  const factory SettingsEvent.clearCache() = ClearCacheEvent;

  const factory SettingsEvent.changeLanguage() = ChangeLanguageEvent;

  const factory SettingsEvent.savePersonInfo() = SavePersonInfoEvent;
}
