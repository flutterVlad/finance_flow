import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '/data/models/currency/currency.dart';
import '/domain/repositories/currency_repository.dart';

final class CurrencyRepositoryImpl implements CurrencyRepository {
  const CurrencyRepositoryImpl();

  @override
  Future<List<CurrencyModel>> fetchCurrencies() async {
    try {
      final response = await Dio().get(
        'https://api.nbrb.by/exrates/currencies',
      );
      final items = response.data as List<Map<String, dynamic>>;

      return items.map(CurrencyModel.fromJson).toList();
    } on DioException catch (e) {
      debugPrint(e.message);
      return [];
    }
  }

  @override
  Future<List<Rate>> fetchRates() async {
    try {
      final response = await Dio().get(
        'https://api.nbrb.by/exrates/rates',
        queryParameters: {'periodicity': 0},
      );
      final items = response.data as List<dynamic>;

      return items.map((el) => Rate.fromJson(el)).toList();
    } on DioException catch (e) {
      debugPrint(e.message);
      return [];
    }
  }
}
