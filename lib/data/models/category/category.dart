import 'package:finance_flow/utils/svgs/svgs.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '/utils/extensions.dart';

part 'category.freezed.dart';
part 'category.g.dart';

// @JsonSerializable()
// class Category extends Equatable {
//   final int id;
//
//   final String name;
//
//   final bool isIncome;
//
//   final String? parentId;
//
//   final double? budget;
//
//   @JsonKey(fromJson: ColorHelper.colorFromJson, toJson: ColorHelper.colorToJson)
//   final Color color;
//
//   final SvgData iconAsset;
//
//   const Category({
//     required this.id,
//     required this.name,
//     this.isIncome = false,
//     this.parentId,
//     this.budget,
//     this.color = Colors.grey,
//     this.iconAsset = Svgs.home,
//   });
//
//   factory Category.empty() => const Category(id: -1, name: 'Empty');
//
//   factory Category.fromJson(Map<String, dynamic> json) =>
//       _$CategoryFromJson(json);
//
//   Map<String, dynamic> toJson() => _$CategoryToJson(this);
//
//   @override
//   List<Object?> get props => [
//     id,
//     name,
//     isIncome,
//     parentId,
//     budget,
//     color,
//     iconAsset,
//   ];
// }

@freezed
abstract class Category with _$Category {
  const Category._();

  const factory Category({
    required int id,
    required String name,
    @Default(false) bool isIncome,
    String? parentId,
    double? budget,
    @JsonKey(
      fromJson: ColorHelper.colorFromJson,
      toJson: ColorHelper.colorToJson,
    )
    @Default(Colors.grey)
    Color color,
    @JsonKey(
      fromJson: SvgDataHelper.svgDataFromJson,
      toJson: SvgDataHelper.svgDataToJson,
    )
    @Default(Svgs.home)
    SvgData iconAsset,
  }) = _Category;

  static const empty = Category(id: -1, name: 'Empty');

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}

// Предопределенные категории
final defaultCategories = [
  // Расходы
  const Category(
    id: 0,
    name: 'Food',
    budget: 15000,
    color: Colors.green,
    iconAsset: Svgs.food,
  ),
  const Category(
    id: 1,
    name: 'Transport',
    budget: 5000,
    color: Colors.blue,
    iconAsset: Svgs.transport,
  ),
  const Category(
    id: 2,
    name: 'Entertainment',
    budget: 3000,
    color: Colors.pink,
    iconAsset: Svgs.entertainment,
  ),
  const Category(
    id: 3,
    name: 'Shopping',
    budget: 3000,
    color: Colors.purple,
    iconAsset: Svgs.shopping,
  ),
  const Category(
    id: 4,
    name: 'Bills',
    budget: 3000,
    color: Colors.red,
    iconAsset: Svgs.bill,
  ),
  const Category(
    id: 5,
    name: 'Healthcare',
    budget: 3000,
    color: Colors.cyan,
    iconAsset: Svgs.healthcare,
  ),
  const Category(
    id: 6,
    name: 'Education',
    budget: 3000,
    color: Colors.orange,
    iconAsset: Svgs.education,
  ),
  const Category(
    id: 7,
    name: 'Other',
    budget: 3000,
    color: Colors.grey,
    iconAsset: Svgs.other,
  ),
  const Category(
    id: 8,
    name: 'Restaurants',
    budget: 3000,
    color: Colors.deepOrange,
    iconAsset: Svgs.restaurant,
  ),
  const Category(
    id: 9,
    name: 'Coffee',
    budget: 3000,
    color: Colors.brown,
    iconAsset: Svgs.coffee,
  ),
  const Category(
    id: 10,
    name: 'Pharmacy',
    budget: 3000,
    color: Colors.redAccent,
    iconAsset: Svgs.pharmacy,
  ),
  const Category(
    id: 11,
    name: 'Books',
    budget: 3000,
    color: Colors.teal,
    iconAsset: Svgs.books,
  ),
  const Category(
    id: 12,
    name: 'Sports',
    budget: 3000,
    color: Colors.cyan,
    iconAsset: Svgs.sport,
  ),
  const Category(
    id: 13,
    name: 'Subscriptions',
    budget: 3000,
    color: Colors.indigo,
    iconAsset: Svgs.subscription,
  ),
  const Category(
    id: 14,
    name: 'Beauty',
    budget: 3000,
    color: Colors.deepPurple,
    iconAsset: Svgs.beauty,
  ),
  const Category(
    id: 15,
    name: 'Gifts',
    budget: 3000,
    color: Colors.amber,
    iconAsset: Svgs.gifts,
  ),
  const Category(
    id: 16,
    name: 'Clothing',
    budget: 3000,
    color: Colors.pinkAccent,
    iconAsset: Svgs.clothing,
  ),
  const Category(
    id: 17,
    name: 'Electronics',
    budget: 3000,
    color: Colors.blueGrey,
    iconAsset: Svgs.electronics,
  ),
  const Category(
    id: 18,
    name: 'Car',
    budget: 3000,
    color: Colors.deepPurpleAccent,
    iconAsset: Svgs.car,
  ),
  const Category(
    id: 19,
    name: 'Home',
    budget: 3000,
    color: Colors.lightBlue,
    iconAsset: Svgs.home,
  ),
  const Category(
    id: 20,
    name: 'Travel',
    budget: 3000,
    color: Colors.lightGreen,
    iconAsset: Svgs.travel,
  ),
  const Category(
    id: 21,
    name: 'Games',
    budget: 3000,
    color: Colors.purpleAccent,
    iconAsset: Svgs.games,
  ),
  Category(
    id: 22,
    name: 'Music',
    budget: 3000,
    color: Colors.pink.shade300,
    iconAsset: Svgs.music,
  ),
  const Category(
    id: 23,
    name: 'Fitness',
    budget: 3000,
    color: Colors.cyanAccent,
    iconAsset: Svgs.fitness,
  ),
  const Category(
    id: 24,
    name: 'Taxi',
    budget: 3000,
    color: Colors.blueAccent,
    iconAsset: Svgs.taxi,
  ),
  const Category(
    id: 25,
    name: 'Gasoline',
    budget: 3000,
    color: Colors.orangeAccent,
    iconAsset: Svgs.gasoline,
  ),
  Category(
    id: 26,
    name: 'Insurance',
    budget: 3000,
    color: Colors.red.shade300,
    iconAsset: Svgs.insurance,
  ),
  Category(
    id: 27,
    name: 'Loan',
    budget: 3000,
    color: Colors.red.shade800,
    iconAsset: Svgs.loan,
  ),
  Category(
    id: 28,
    name: 'Taxes',
    budget: 3000,
    color: Colors.brown.shade700,
    iconAsset: Svgs.taxes,
  ),
  const Category(
    id: 29,
    name: 'Charity',
    budget: 3000,
    color: Colors.greenAccent,
    iconAsset: Svgs.charity,
  ),
  Category(
    id: 30,
    name: 'Pets',
    budget: 3000,
    color: Colors.amber.shade300,
    iconAsset: Svgs.pets,
  ),
  Category(
    id: 31,
    name: 'Children',
    budget: 3000,
    color: Colors.pink.shade200,
    iconAsset: Svgs.children,
  ),
  const Category(
    id: 32,
    name: 'Hobby',
    budget: 3000,
    color: Colors.lightGreenAccent,
    iconAsset: Svgs.hobby,
  ),
  // Доходы
  const Category(
    id: 33,
    name: 'Salary',
    isIncome: true,
    color: Colors.green,
    iconAsset: Svgs.salary,
  ),
];
