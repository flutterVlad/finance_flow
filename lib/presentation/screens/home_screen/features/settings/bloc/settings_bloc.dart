import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

import '/data/models/account/account.dart';
import '/data/models/bank_card/bank_card.dart';
import '/data/models/response/response.dart';
import '/domain/repositories/card_repository.dart';
import '/domain/repositories/settings_repository.dart';
import '/domain/use_cases/delete_account_use_case.dart';
import '/presentation/screens/home_screen/features/settings/bloc/forms.dart';
import '/presentation/screens/wallet_screen/entities/card_form.dart';

part 'settings_bloc.freezed.dart';
part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({
    required this.settingsRepository,
    required this.cardRepository,
    required this.deleteAccountUseCase,
  }) : super(const SettingsState()) {
    on<SettingsEvent>((event, emit) async {
      await event.map(
        init: (_) async => await _init(emit),
        clearCache: (_) async => await _clearCache(emit),
        changeLocale: (event) async => await _changeLocale(event, emit),
        savePersonInfo: (event) async => await _savePersonInfo(event, emit),
        deleteAccount: (event) async => await _deleteAccount(event, emit),
        deleteAllAccounts: (_) async => await _deleteAllAccounts(emit),
        getCards: (_) async => await _getCards(emit),
        saveCard: (event) async => await _saveCard(event, emit),
        removeCard: (event) async => await _removeCard(event, emit),
      );
    });

    add(const InitSettingsEvent());
  }
  final SettingsRepository settingsRepository;
  final CardRepository cardRepository;
  final DeleteAccountUseCase deleteAccountUseCase;

  Future<void> _init(Emitter<SettingsState> emit) async {
    final accounts = await settingsRepository.fetchAllAccount();
    final locale = await settingsRepository.getLocale();
    final account = await settingsRepository.fetchAccount(accounts);

    emit(
      state.copyWith(
        selectedAccount: account,
        allAccounts: accounts,
        locale: locale,
      ),
    );
  }

  Future<void> _clearCache(Emitter<SettingsState> emit) async {}

  Future<void> _changeLocale(
    ChangeLocaleEvent event,
    Emitter<SettingsState> emit,
  ) async {
    await settingsRepository.saveLocale(event.lang);
    emit(state.copyWith(locale: Locale(event.lang)));
  }

  Future<void> _savePersonInfo(
    SavePersonInfoEvent event,
    Emitter<SettingsState> emit,
  ) async {
    final (response, account) = await settingsRepository.savePersonInfo(
      event.form,
    );

    emit(state.copyWith(selectedAccount: account, response: response));
    emit(state.copyWith(response: null));
  }

  Future<void> _deleteAccount(
    DeleteAccountEvent event,
    Emitter<SettingsState> emit,
  ) async {
    final response = await settingsRepository.deleteAccount(event.uid);

    emit(state.copyWith(response: response, cards: []));
    emit(state.copyWith(response: null));
  }

  Future<void> _deleteAllAccounts(Emitter<SettingsState> emit) async {
    final response = await settingsRepository.deleteAllAccounts();

    emit(
      state.copyWith(
        response: response,
        cards: [],
        allAccounts: [],
        selectedAccount: null,
      ),
    );
    emit(state.copyWith(response: null));
  }

  Future<void> _getCards(Emitter<SettingsState> emit) async {
    if (state.selectedAccount != null) {
      final cards = await cardRepository.getCards(
        state.selectedAccount!.uid!.uuid,
      );
      emit(state.copyWith(cards: cards, response: null));
    }
  }

  Future<void> _saveCard(
    SaveCardEvent event,
    Emitter<SettingsState> emit,
  ) async {
    if (state.selectedAccount != null) {
      final response = await cardRepository.saveCard(
        event.form,
        state.selectedAccount!.uid!.uuid,
      );
      emit(state.copyWith(response: response));
      add(const GetCardsEvent());
    }
  }

  Future<void> _removeCard(
    RemoveCardEvent event,
    Emitter<SettingsState> emit,
  ) async {
    if (state.selectedAccount != null) {
      final response = await cardRepository.deleteCard(
        event.id,
        state.selectedAccount!.uid!.uuid,
      );
      emit(state.copyWith(response: response));
      add(const GetCardsEvent());
    }
  }
}
