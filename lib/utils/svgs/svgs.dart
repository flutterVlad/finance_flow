import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../extensions.dart';

part 'svgs.freezed.dart';
part 'svgs.g.dart';

@freezed
abstract class SvgData with _$SvgData {
  const SvgData._();

  const factory SvgData(
    String asset, {
    @JsonKey(
      fromJson: ColorHelper.colorFromJson,
      toJson: ColorHelper.colorToJson,
    )
    @Default(Colors.grey)
    Color color,
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

  static const SvgData money = SvgData('assets/svg/money.svg', size: 35);

  static const SvgData category = SvgData('assets/svg/category.svg', size: 35);

  static const SvgData visa = SvgData('assets/svg/visa.svg', size: 35);

  static const SvgData home = SvgData('assets/svg/home.svg', size: 20);

  static const SvgData wallet = SvgData('assets/svg/wallet.svg', size: 20);

  static const SvgData addRounded = SvgData(
    'assets/svg/add_rounded.svg',
    size: 20,
  );

  static const SvgData pieChart = SvgData('assets/svg/pie_chart.svg', size: 20);

  static const SvgData beauty = SvgData('assets/svg/beauty.svg', size: 20);

  static const SvgData bill = SvgData('assets/svg/bill.svg', size: 20);

  static const SvgData books = SvgData('assets/svg/books.svg', size: 20);

  static const SvgData car = SvgData('assets/svg/car.svg', size: 20);

  static const SvgData charity = SvgData('assets/svg/charity.svg', size: 20);

  static const SvgData children = SvgData('assets/svg/children.svg', size: 20);

  static const SvgData clothing = SvgData('assets/svg/clothing.svg', size: 20);

  static const SvgData coffee = SvgData('assets/svg/coffee.svg', size: 20);

  static const SvgData education = SvgData(
    'assets/svg/education.svg',
    size: 20,
  );

  static const SvgData electronics = SvgData(
    'assets/svg/electronics.svg',
    size: 20,
  );

  static const SvgData entertainment = SvgData(
    'assets/svg/entertainment.svg',
    size: 20,
  );

  static const SvgData fitness = SvgData('assets/svg/fitness.svg', size: 20);

  static const SvgData food = SvgData('assets/svg/food.svg', size: 20);

  static const SvgData games = SvgData('assets/svg/games.svg', size: 20);

  static const SvgData gasoline = SvgData('assets/svg/gasoline.svg', size: 20);

  static const SvgData gifts = SvgData('assets/svg/gifts.svg', size: 20);

  static const SvgData healthcare = SvgData(
    'assets/svg/healthcare.svg',
    size: 20,
  );

  static const SvgData hobby = SvgData('assets/svg/hobby.svg', size: 20);

  static const SvgData insurance = SvgData(
    'assets/svg/insurance.svg',
    size: 20,
  );

  static const SvgData loan = SvgData('assets/svg/loan.svg', size: 20);

  static const SvgData music = SvgData('assets/svg/music.svg', size: 20);

  static const SvgData other = SvgData('assets/svg/other.svg', size: 20);

  static const SvgData pets = SvgData('assets/svg/pets.svg', size: 20);

  static const SvgData pharmacy = SvgData('assets/svg/pharmacy.svg', size: 20);

  static const SvgData restaurant = SvgData(
    'assets/svg/restaurant.svg',
    size: 20,
  );

  static const SvgData salary = SvgData('assets/svg/salary.svg', size: 20);

  static const SvgData shopping = SvgData('assets/svg/shopping.svg', size: 20);

  static const SvgData sport = SvgData('assets/svg/sport.svg', size: 20);

  static const SvgData subscription = SvgData(
    'assets/svg/subscriptions.svg',
    size: 20,
  );

  static const SvgData taxes = SvgData('assets/svg/taxes.svg', size: 20);

  static const SvgData taxi = SvgData('assets/svg/taxi.svg', size: 20);

  static const SvgData transport = SvgData(
    'assets/svg/transport.svg',
    size: 20,
  );

  static const SvgData travel = SvgData('assets/svg/travel.svg', size: 20);
}
