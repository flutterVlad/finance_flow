import 'package:hive_flutter/hive_flutter.dart';

import '/data/models/account/account_adapter.dart';
import '/data/models/bank_card/bank_card_adapter.dart';
import '/data/models/category/category_adapter.dart';
import '/data/models/day_expenses/day_expenses_adapter.dart';
import '/data/models/expense/expense_adapter.dart';
import '/data/models/recurrence/recurrence_adapter.dart';
import '/data/models/response/response.dart';

class HiveService {
  const HiveService();

  Future<void> init() async {
    await Hive.initFlutter();
    _registerAdapters();
  }

  void _registerAdapters() {
    Hive.registerAdapter(const AccountAdapter());
    Hive.registerAdapter(const CategoryAdapter());
    Hive.registerAdapter(const DayExpensesAdapter());
    Hive.registerAdapter(const ExpenseAdapter());
    Hive.registerAdapter(const RecurrenceAdapter());
    Hive.registerAdapter(const RecurrenceTypeAdapter());
    Hive.registerAdapter(const BankCardAdapter());
  }

  Future<T?> getData<T>(dynamic key, {List<int>? encryptKey}) async {
    try {
      final box = await _openBox<T>(encryptKey);
      final T? model = box.get(key);

      return model;
    } on HiveError catch (_) {
      rethrow;
    }
  }

  Future<List<T>> getAllData<T>({List<int>? encryptKey}) async {
    try {
      final box = await _openBox<T>(encryptKey);
      final List<T> data = box.values.toList();

      return data;
    } on HiveError catch (_) {
      rethrow;
    }
  }

  Future<Response> putData<T>(
    dynamic key,
    T model, {
    List<int>? encryptKey,
  }) async {
    try {
      final box = await _openBox<T>(encryptKey);

      await box.put(key, model);
      return const Response(message: 'Data put to hive', success: true);
    } on HiveError catch (e) {
      return Response(message: e.message);
    }
  }

  Future<Response> deleteData<T>(dynamic key, {List<int>? encryptKey}) async {
    try {
      final box = await _openBox<T>(encryptKey);

      await box.delete(key);
      return const Response(message: 'Data delete from give', success: true);
    } on HiveError catch (e) {
      return Response(message: e.message, success: false);
    }
  }

  Future<Response> deleteAllData<T>({List<int>? encryptKey}) async {
    try {
      final box = await _openBox<T>(encryptKey);
      await box.clear();

      return const Response(
        message: 'All data delete from hive',
        success: true,
      );
    } on HiveError catch (e) {
      return Response(message: e.message, success: false);
    }
  }

  Future<Response> updateData<T>(
    dynamic key,
    T model, {
    List<int>? encryptKey,
  }) async {
    try {
      final box = await _openBox<T>(encryptKey);

      await box.put(key, model);
      return const Response(message: 'Data updated in hive', success: true);
    } on HiveError catch (e) {
      return Response(message: e.message, success: false);
    }
  }

  Future<Box<T>> _openBox<T>([List<int>? encryptKey]) async {
    return await Hive.openBox<T>(
      T.toString(),
      encryptionCipher: encryptKey != null ? HiveAesCipher(encryptKey) : null,
    );
  }
}
