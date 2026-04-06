import '/data/models/currency/currency.dart';

abstract class CurrencyRepository {
  Future<List<CurrencyModel>> fetchCurrencies();

  Future<List<Rate>> fetchRates();
}
