import 'package:hive_flutter/hive_flutter.dart';

import '/data/models/hive_adapter_ids.dart';
import 'account.dart';

class AccountAdapter extends TypeAdapter<Account> {
  @override
  final int typeId = HiveAdapterIds.account;

  @override
  Account read(BinaryReader reader) {
    final json = reader.readMap() as Map<String, dynamic>;
    return Account.fromJson(json);
  }

  @override
  void write(BinaryWriter writer, Account obj) {
    writer.writeMap(obj.toJson());
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
