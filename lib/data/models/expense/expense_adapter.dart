import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '/data/models/hive_adapter_ids.dart';
import 'expense.dart';

class ExpenseAdapter implements TypeAdapter<Expense> {
  const ExpenseAdapter();

  @override
  final int typeId = HiveAdapterIds.expense;

  @override
  Expense read(BinaryReader reader) {
    final map = Map<String, dynamic>.from(reader.readMap());
    return Expense(
      id: UuidValue.fromString(map['id']),
      name: map['name'],
      category: map['category'],
      datetime: DateTime.parse(map['datetime']),
      price: map['price'],
      isIncome: map['isIncome'],
      accountId: map['accountId'],
    );
  }

  @override
  void write(BinaryWriter writer, Expense obj) {
    writer.writeMap(obj.toJson());
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
