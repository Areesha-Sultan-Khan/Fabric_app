// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 1;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product(
      fields[0] as int,
      fields[1] as String,
      fields[2] as double,
      fields[3] as String,
      fields[4] as double,
      fields[5] as String,
      fields[6] as bool,
      fields[7] as bool,
      fields[8] as int,
      fields[9] as int,
      fields[10] as DateTime,
      fields[11] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.photo)
      ..writeByte(4)
      ..write(obj.discount)
      ..writeByte(5)
      ..write(obj.detail)
      ..writeByte(6)
      ..write(obj.is_hot_product)
      ..writeByte(7)
      ..write(obj.is_new_arrival)
      ..writeByte(8)
      ..write(obj.category_id)
      ..writeByte(9)
      ..write(obj.user_id)
      ..writeByte(10)
      ..write(obj.created_at)
      ..writeByte(11)
      ..write(obj.updated_at);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
