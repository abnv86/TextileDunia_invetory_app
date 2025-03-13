import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:app/modal/product_modal.dart'; // Adjust the import path

class ProductService {
  // Hive box for products
  final Box<ProductModal> _productBox = Hive.box<ProductModal>('productBox');

  // Add a new product
  Future<void> addProduct(String itemName ,String brandName,String productCategory, int productQty,int purchaseRate ,int salesRtae,int minimumQAlert,String size,String color,List<File> images) async {
  List<String> imagePaths = images.map((image) => image.path).toList();
  ProductModal product = ProductModal(
    itemName: itemName,
    productBrandName: brandName, productCategory: productCategory, productQuantity: productQty, productPurchaseRate: purchaseRate, productSalesRate: salesRtae, productMinimumQuantity: minimumQAlert, productSize: size, productColor: color, productImages: imagePaths);
  await _productBox.add(product);
}


  // Get all products
  List<ProductModal> getAllProducts() {
    return _productBox.values.toList();
  }

  // Update a product
  Future<void> updateProduct(int key, ProductModal updatedProduct) async {
    await _productBox.put(key, updatedProduct);
  }

  // Delete a product
  Future<void> deleteProduct(int key) async {
    await _productBox.delete(key);
  }
}