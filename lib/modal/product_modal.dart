import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';

part 'product_modal.g.dart'; 


@HiveType(typeId: 3)
class ProductModal extends HiveObject{

@HiveField(0)
String itemName;

@HiveField(1)
String productBrandName;

@HiveField(2)
String productCategory;

@HiveField(3)
int productQuantity;


@HiveField(4)
int productPurchaseRate;


@HiveField(5)
int productSalesRate;


@HiveField(6)
int productMinimumQuantity;


@HiveField(7)
String productSize;


@HiveField(8)
String productColor;


@HiveField(9)
List<String> productImages;


ProductModal({
  required this.itemName,
  required this.productBrandName,
  required this.productCategory,
  required this.productQuantity,
  required this.productPurchaseRate,
  required this.productSalesRate,
  required this.productMinimumQuantity,
  required this.productSize,
  required this.productColor,
  required this.productImages
});

}

