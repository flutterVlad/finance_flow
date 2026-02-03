import 'package:hive_flutter/hive_flutter.dart';

import '/data/models/hive_adapter_ids.dart';
import 'recurrence.dart';

class RecurrenceAdapter implements TypeAdapter<Recurrence> {
  const RecurrenceAdapter();

  @override
  final int typeId = HiveAdapterIds.recurrence;

  @override
  Recurrence read(BinaryReader reader) {
    final json = reader.readMap() as Map<String, dynamic>;
    return Recurrence.fromJson(json);
  }

  @override
  void write(BinaryWriter writer, Recurrence obj) {
    writer.writeMap(obj.toJson());
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecurrenceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RecurrenceTypeAdapter implements TypeAdapter<RecurrenceType> {
  const RecurrenceTypeAdapter();

  @override
  final int typeId = HiveAdapterIds.recurrenceType;

  @override
  RecurrenceType read(BinaryReader reader) {
    final index = reader.readInt();
    return RecurrenceType.values[index];
  }

  @override
  void write(BinaryWriter writer, RecurrenceType obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecurrenceTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
