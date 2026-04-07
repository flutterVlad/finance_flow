import 'package:freezed_annotation/freezed_annotation.dart';

import '/utils/svgs/svg.dart';

part 'currency.freezed.dart';
part 'currency.g.dart';

@freezed
abstract class CurrencyModel with _$CurrencyModel {
  const factory CurrencyModel({
    @JsonKey(name: "Cur_ID") required int id,
    @JsonKey(name: "Cur_Name") required String name,
    @JsonKey(name: "Cur_Abbreviation") required String shortName,
  }) = _CurrencyModel;

  factory CurrencyModel.fromJson(Map<String, dynamic> json) =>
      _$CurrencyModelFromJson(json);
}

@freezed
abstract class Rate with _$Rate {
  const Rate._();

  const factory Rate({
    @JsonKey(name: "Cur_ID") required int id,
    @JsonKey(name: "Date") required DateTime date,
    @JsonKey(name: "Cur_Abbreviation") required String shortName,
    @JsonKey(name: "Cur_Scale") required int scale,
    @JsonKey(name: "Cur_Name") required String name,
    @JsonKey(name: "Cur_OfficialRate") required double value,
  }) = _Rate;

  static Rate get blrRate => Rate(
    id: 0,
    date: DateTime.now(),
    shortName: 'BLR',
    scale: 1,
    name: 'Белорусский рубль',
    value: 1,
  );

  factory Rate.fromJson(Map<String, dynamic> json) => _$RateFromJson(json);
}

enum Currency {
  dollar("Доллар США", "USD", Svgs.dollar),
  byn("Белорусский рубль", "BLR", Svgs.byn),
  euro("Евро", "EUR", Svgs.euro),
  lir("Турецкая лира", "TRY", Svgs.lir);

  const Currency(this.name, this.shortName, this.icon);

  final String name;
  final SvgData icon;
  final String shortName;
}
