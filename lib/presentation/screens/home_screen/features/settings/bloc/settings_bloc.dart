import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

import '/data/models/account/account.dart';
import '/data/models/bank_card/bank_card.dart';
import '/data/models/response/response.dart';
import '/domain/repositories/card_repository.dart';
import '/domain/repositories/settings_repository.dart';
import '/presentation/screens/home_screen/features/settings/bloc/forms.dart';
import '/presentation/screens/wallet_screen/entities/card_form.dart';

part 'settings_bloc.freezed.dart';
part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository settingsRepository;
  final CardRepository cardRepository;

  SettingsBloc({required this.settingsRepository, required this.cardRepository})
    : super(const SettingsState()) {
    on<SettingsEvent>((event, emit) async {
      await event.map(
        init: (_) async => await _init(emit),
        clearCache: (_) async => await _clearCache(emit),
        changeLanguage: (_) async => await _changeLang(emit),
        savePersonInfo: (event) async => await _savePersonInfo(event, emit),
        createAccount: (event) async => await _createAccount(event, emit),
        deleteAccount: (event) async => await _deleteAccount(event, emit),
        deleteAllAccounts: (_) async => await _deleteAllAccounts(emit),
        getCards: (_) async => await _getCards(emit),
        saveCard: (event) async => await _saveCard(event, emit),
        removeCard: (event) async => await _removeCard(event, emit),
      );
    });

    add(const InitSettingsEvent());
  }

  Future<void> _init(Emitter<SettingsState> emit) async {
    final accounts = await settingsRepository.fetchAllAccount();

    if (accounts.isNotEmpty) {
      final account = await settingsRepository.fetchAccount(accounts);
      emit(state.copyWith(selectedAccount: account, allAccounts: accounts));
    }
  }

  Future<void> _clearCache(Emitter<SettingsState> emit) async {}

  Future<void> _changeLang(Emitter<SettingsState> emit) async {}

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

  Future<void> _createAccount(
    CreateAccountEvent event,
    Emitter<SettingsState> emit,
  ) async {
    final (response, account) = await settingsRepository.createAccount(
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
      emit(state.copyWith(cards: cards));
    }
  }

  Future<void> _saveCard(
    SaveCardEvent event,
    Emitter<SettingsState> emit,
  ) async {
    if (state.selectedAccount != null) {
      await cardRepository.saveCard(
        event.form,
        state.selectedAccount!.uid!.uuid,
      );
      add(const GetCardsEvent());
    }
  }

  Future<void> _removeCard(
    RemoveCardEvent event,
    Emitter<SettingsState> emit,
  ) async {
    if (state.selectedAccount != null) {
      await cardRepository.deleteCard(
        event.number,
        state.selectedAccount!.uid!.uuid,
      );
      add(const GetCardsEvent());
    }
  }
}
