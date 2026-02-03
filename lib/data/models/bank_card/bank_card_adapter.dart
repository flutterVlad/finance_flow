import 'package:hive_flutter/adapters.dart';

import '/data/models/hive_adapter_ids.dart';
import 'bank_card.dart';

class BankCardAdapter implements TypeAdapter<BankCard> {
  const BankCardAdapter();

  @override
  final int typeId = HiveAdapterIds.bankCard;

  @override
  BankCard read(BinaryReader reader) {
    final json = Map<String, dynamic>.from(reader.readMap());
    return BankCard.fromJson(json);
  }

  @override
  void write(BinaryWriter writer, BankCard obj) {
    writer.writeMap(obj.toJson());
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BankCardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
