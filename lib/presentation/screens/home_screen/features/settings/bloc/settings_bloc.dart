import 'package:finance_flow/domain/repositories/settings_repository.dart';
import 'package:finance_flow/presentation/screens/home_screen/features/settings/bloc/forms.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

import '/data/models/account/account.dart';

part 'settings_bloc.freezed.dart';
part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository settingsRepository;

  SettingsBloc({required this.settingsRepository})
    : super(const SettingsState()) {
    on<SettingsEvent>((event, emit) async {
      await event.map(
        init: (_) async => await _init(emit),
        clearCache: (_) async => await _clearCache(emit),
        changeLanguage: (_) async => await _changeLang(emit),
        savePersonInfo: (event) async => await _savePersonInfo(event, emit),
      );
    });

    add(const InitSettingsEvent());
  }

  Future<void> _init(Emitter<SettingsState> emit) async {
    final accounts = await settingsRepository.fetchAllAccount();

    if (accounts.isNotEmpty) {
      final account = await settingsRepository.fetchAccount(accounts);
      emit(state.copyWith(account: account));
    }
  }

  Future<void> _clearCache(Emitter<SettingsState> emit) async {}

  Future<void> _changeLang(Emitter<SettingsState> emit) async {}

  Future<void> _savePersonInfo(
    SettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {}
}
