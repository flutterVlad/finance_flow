part of 'wallet_bloc.dart';

@freezed
abstract class WalletState with _$WalletState {
  const factory WalletState({@Default([]) List<Expense> expenses}) =
      _WalletState;
}
