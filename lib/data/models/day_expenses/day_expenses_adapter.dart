import 'package:hive_flutter/adapters.dart';

import '/data/models/hive_adapter_ids.dart';
import 'day_expenses.dart';

class DayExpensesAdapter extends TypeAdapter<DayExpense> {
  @override
  final int typeId = HiveAdapterIds.dayExpense;

  @override
  DayExpense read(BinaryReader reader) {
    final json = reader.readMap() as Map<String, dynamic>;
    return DayExpense.fromJson(json);
  }

  @override
  void write(BinaryWriter writer, DayExpense obj) {
    writer.writeMap(obj.toJson());
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayExpensesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
