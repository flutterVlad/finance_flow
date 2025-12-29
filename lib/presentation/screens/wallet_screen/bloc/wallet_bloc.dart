import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '/data/models/expense/expense.dart';

part 'wallet_bloc.freezed.dart';
part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(const WalletState()) {
    on<WalletEvent>((event, emit) async {
      await event.map(init: (_) {});
    });

    add(const InitWalletEvent());
  }
}
