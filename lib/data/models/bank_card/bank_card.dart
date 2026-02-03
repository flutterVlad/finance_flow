import 'package:finance_flow/utils/svgs/svg.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bank_card.freezed.dart';
part 'bank_card.g.dart';

enum CardType { visa, mastercard, belcard, mir, unionPay, unknown }

@freezed
abstract class BankCard with _$BankCard {
  const BankCard._();

  const factory BankCard({
    @Default(CardType.unknown) CardType cardType,
    @Default('') String number,
    @Default('') String owner,
    @Default('') String duration,
    @Default('') String cvv,
  }) = _BankCard;

  factory BankCard.fromJson(Map<String, dynamic> json) =>
      _$BankCardFromJson(json);

  String get formatNumber =>
      formatStringWithReplace(value: number, length: 16, replace: (' ', 2));

  String get formatOwner => owner.toUpperCase();

  String get formatDuration =>
      formatStringWithReplace(value: duration, length: 4, replace: ('/', 2));

  String get formatCVV => cvv;

  static String formatStringWithReplace({
    required String value,
    required int length,
    required (String, int) replace,
  }) {
    String digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length > length) {
      digitsOnly = digitsOnly.substring(0, length);
    }

    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < digitsOnly.length; i++) {
      if (i > 0 && i % replace.$2 == 0) buffer.write(replace.$1);
      buffer.write(digitsOnly[i]);
    }
    return buffer.toString();
  }

  SvgData get cardIcon => switch (cardType) {
    CardType.visa => Svgs.visa,
    CardType.mastercard => Svgs.mastercard,
    CardType.belcard => Svgs.belcard,
    CardType.mir => Svgs.mir,
    CardType.unionPay => Svgs.unionPay,
    _ => Svgs.unknownCard,
  };
}
