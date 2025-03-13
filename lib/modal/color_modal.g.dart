// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'color_modal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ColorModalAdapter extends TypeAdapter<ColorModal> {
  @override
  final int typeId = 4;

  @override
  ColorModal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ColorModal(
      colorName: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ColorModal obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.colorName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ColorModalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
