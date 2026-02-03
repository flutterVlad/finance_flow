import 'package:hive_flutter/adapters.dart';

import '/data/models/hive_adapter_ids.dart';
import 'category.dart';

class CategoryAdapter implements TypeAdapter<Category> {
  const CategoryAdapter();

  @override
  final int typeId = HiveAdapterIds.category;

  @override
  Category read(BinaryReader reader) {
    final json = Map<String, dynamic>.from(reader.readMap());
    return Category.fromJson(json);
  }

  @override
  void write(BinaryWriter writer, Category obj) {
    writer.writeMap(obj.toJson());
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
