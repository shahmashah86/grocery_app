// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartEntityAdapter extends TypeAdapter<CartEntity> {
  @override
  final int typeId = 1;

  @override
  CartEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartEntity(
      id: fields[0] as int,
      prodName: fields[1] as String,
      price: fields[2] as double,
      quantity: fields[3] as int,
      url: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CartEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.prodName)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.quantity)
      ..writeByte(4)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
