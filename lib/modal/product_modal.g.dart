// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_modal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductModalAdapter extends TypeAdapter<ProductModal> {
  @override
  final int typeId = 3;

  @override
  ProductModal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModal(
      itemName: fields[0] as String,
      productBrandName: fields[1] as String,
      productCategory: fields[2] as String,
      productQuantity: fields[3] as int,
      productPurchaseRate: fields[4] as int,
      productSalesRate: fields[5] as int,
      productMinimumQuantity: fields[6] as int,
      productSize: fields[7] as String,
      productColor: fields[8] as String,
      productImages: (fields[9] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, ProductModal obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.itemName)
      ..writeByte(1)
      ..write(obj.productBrandName)
      ..writeByte(2)
      ..write(obj.productCategory)
      ..writeByte(3)
      ..write(obj.productQuantity)
      ..writeByte(4)
      ..write(obj.productPurchaseRate)
      ..writeByte(5)
      ..write(obj.productSalesRate)
      ..writeByte(6)
      ..write(obj.productMinimumQuantity)
      ..writeByte(7)
      ..write(obj.productSize)
      ..writeByte(8)
      ..write(obj.productColor)
      ..writeByte(9)
      ..write(obj.productImages);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
