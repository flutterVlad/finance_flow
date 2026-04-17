part of 'svg.dart';

@freezed
abstract class SvgData with _$SvgData {
  const SvgData._();

  const factory SvgData(
    String asset, {
    @JsonKey(
      fromJson: ColorHelper.colorFromJson,
      toJson: ColorHelper.colorToJson,
    )
    // @Default(Colors.grey)
    Color? color,
    @Default(20) double size,
  }) = _SvgData;

  factory SvgData.fromJson(Map<String, dynamic> json) =>
      _$SvgDataFromJson(json);
}

class Svgs {
  static const SvgData mastercard = SvgData(
    'assets/svg/mastercard.svg',
    size: 35,
  );

  static const SvgData mir = SvgData('assets/svg/mir.svg');

  static const SvgData unknownCard = SvgData('assets/svg/unknown_card.svg');

  static const SvgData unionPay = SvgData('assets/svg/union_pay.svg');

  static const SvgData money = SvgData('assets/svg/money.svg', size: 35);

  static const SvgData category = SvgData('assets/svg/category.svg', size: 35);

  static const SvgData visa = SvgData('assets/svg/visa.svg', size: 35);

  static const SvgData home = SvgData('assets/svg/home.svg');

  static const SvgData wallet = SvgData('assets/svg/wallet.svg');

  static const SvgData addRounded = SvgData('assets/svg/add_rounded.svg');

  static const SvgData pieChart = SvgData('assets/svg/pie_chart.svg');

  static const SvgData beauty = SvgData('assets/svg/beauty.svg');

  static const SvgData belcard = SvgData('assets/svg/belcard.svg');

  static const SvgData bill = SvgData('assets/svg/bill.svg');

  static const SvgData books = SvgData('assets/svg/books.svg');

  static const SvgData car = SvgData('assets/svg/car.svg');

  static const SvgData charity = SvgData('assets/svg/charity.svg');

  static const SvgData children = SvgData('assets/svg/children.svg');

  static const SvgData clothing = SvgData('assets/svg/clothing.svg');

  static const SvgData coffee = SvgData('assets/svg/coffee.svg');

  static const SvgData education = SvgData('assets/svg/education.svg');

  static const SvgData electronics = SvgData('assets/svg/electronics.svg');

  static const SvgData entertainment = SvgData('assets/svg/entertainment.svg');

  static const SvgData fitness = SvgData('assets/svg/fitness.svg');

  static const SvgData food = SvgData('assets/svg/food.svg');

  static const SvgData games = SvgData('assets/svg/games.svg');

  static const SvgData gasoline = SvgData('assets/svg/gasoline.svg');

  static const SvgData gifts = SvgData('assets/svg/gifts.svg');

  static const SvgData healthcare = SvgData('assets/svg/healthcare.svg');

  static const SvgData hobby = SvgData('assets/svg/hobby.svg');

  static const SvgData insurance = SvgData('assets/svg/insurance.svg');

  static const SvgData loan = SvgData('assets/svg/loan.svg');

  static const SvgData music = SvgData('assets/svg/music.svg');

  static const SvgData other = SvgData('assets/svg/other.svg');

  static const SvgData pets = SvgData('assets/svg/pets.svg');

  static const SvgData pharmacy = SvgData('assets/svg/pharmacy.svg');

  static const SvgData restaurant = SvgData('assets/svg/restaurant.svg');

  static const SvgData salary = SvgData('assets/svg/salary.svg');

  static const SvgData shopping = SvgData('assets/svg/shopping.svg');

  static const SvgData sport = SvgData('assets/svg/sport.svg');

  static const SvgData subscription = SvgData('assets/svg/subscriptions.svg');

  static const SvgData taxes = SvgData('assets/svg/taxes.svg');

  static const SvgData taxi = SvgData('assets/svg/taxi.svg');

  static const SvgData transport = SvgData('assets/svg/transport.svg');

  static const SvgData travel = SvgData('assets/svg/travel.svg');

  static const SvgData byn = SvgData('assets/svg/byn.svg');

  static const SvgData dollar = SvgData('assets/svg/dollar.svg');

  static const SvgData euro = SvgData('assets/svg/euro.svg');

  static const SvgData lir = SvgData('assets/svg/lir.svg');
}
