import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '/data/models/expense/expense.dart';
import '/domain/use_cases/base_use_case.dart';
import '/domain/use_cases/create_mock_expenses_use_case.dart';

part 'wallet_bloc.freezed.dart';
part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final GetMockExpensesUseCase getMockExpensesUseCase;

  WalletBloc({required this.getMockExpensesUseCase})
    : super(const WalletState()) {
    on<WalletEvent>((event, emit) async {
      await event.map(init: (_) async => await _init(emit));
    });

    add(const InitWalletEvent());
  }

  Future<void> _init(Emitter<WalletState> emit) async {
    final expenses = getMockExpensesUseCase.execute(const NoParams());
    emit(state.copyWith(expenses: expenses));
  }
}
