import 'package:hive_flutter/hive_flutter.dart';

import '/data/models/account/account_adapter.dart';
import '/data/models/category/category_adapter.dart';
import '/data/models/day_expenses/day_expenses_adapter.dart';
import '/data/models/expense/expense_adapter.dart';
import '/data/models/recurrence/recurrence_adapter.dart';
import '/data/models/response/response.dart';

class HiveService {
  Future<void> init() async {
    await Hive.initFlutter();
    _registerAdapters();
  }

  void _registerAdapters() {
    Hive.registerAdapter(AccountAdapter());
    Hive.registerAdapter(CategoryAdapter());
    Hive.registerAdapter(DayExpensesAdapter());
    Hive.registerAdapter(ExpenseAdapter());
    Hive.registerAdapter(RecurrenceAdapter());
    Hive.registerAdapter(RecurrenceTypeAdapter());
  }

  Future<T?> getData<T>(dynamic key) async {
    try {
      final box = await Hive.openBox<T>(T.toString());
      final T? model = box.get(key);

      return model;
    } on HiveError catch (_) {
      rethrow;
    }
  }

  Future<List<T>> getAllData<T>() async {
    try {
      final box = await Hive.openBox<T>(T.toString());
      final List<T> data = box.values.toList();

      return data;
    } on HiveError catch (_) {
      rethrow;
    }
  }

  Future<Response> putData<T>(dynamic key, T model) async {
    final box = await Hive.openBox<T>(T.toString());

    try {
      await box.put(key, model);
      return const Response(message: 'Data put to hive', success: true);
    } on HiveError catch (e) {
      return Response(message: e.message);
    }
  }

  Future<Response> deleteData<T>(dynamic key) async {
    final box = await Hive.openBox<T>(T.toString());

    try {
      await box.delete(key);
      return const Response(message: 'Data delete from give', success: true);
    } on HiveError catch (e) {
      return Response(message: e.message);
    }
  }

  Future<Response> deleteAllData<T>() async {
    final box = await Hive.openBox<T>(T.toString());

    try {
      await box.clear();
      return const Response(
        message: 'All data delete from hive',
        success: true,
      );
    } on HiveError catch (e) {
      return Response(message: e.message);
    }
  }

  Future<Response> updateData<T>(dynamic key, T model) async {
    final box = await Hive.openBox<T>(T.toString());

    try {
      await box.put(key, model);
      return const Response(message: 'Data updated in hive', success: true);
    } on HiveError catch (e) {
      return Response(message: e.message);
    }
  }
}
