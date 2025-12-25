part of 'wallet_bloc.dart';

@freezed
abstract class WalletEvent with _$WalletEvent {
  const factory WalletEvent.init() = InitWalletEvent;
}
