// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BrandModalAdapter extends TypeAdapter<BrandModal> {
  @override
  final int typeId = 1;

  @override
  BrandModal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BrandModal(
      brandName: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BrandModal obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.brandName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BrandModalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
