import 'package:hive_flutter/hive_flutter.dart';

import '../models/account/account_adapter.dart';
import '../models/category/category_adapter.dart';
import '../models/day_expenses/day_expenses_adapter.dart';
import '../models/expense/expense_adapter.dart';
import '../models/recurrence/recurrence_adapter.dart';

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
    final box = await Hive.openBox<T>(T.toString());
    final T? model = box.get(key);

    return model;
  }

  Future<List<T>> getAllData<T>() async {
    final box = await Hive.openBox<T>(T.toString());
    final List<T> data = box.values.toList();

    return data;
  }

  Future<void> putData<T>(dynamic key, T model) async {
    final box = await Hive.openBox<T>(T.toString());

    await box.put(key, model);
  }

  Future<void> deleteData<T>(dynamic key) async {
    final box = await Hive.openBox<T>(T.toString());

    await box.delete(key);
  }

  Future<void> deleteAllData<T>() async {
    final box = await Hive.openBox<T>(T.toString());

    await box.clear();
  }

  Future<void> updateData<T>(dynamic key, T model) async {
    final box = await Hive.openBox<T>(T.toString());

    await box.put(key, model);
  }
}
