import 'package:app/modal/brand_model.dart';
import 'package:app/modal/product_modal.dart';
import 'package:hive_flutter/hive_flutter.dart';

void addBrand(String brandName) async {
  var brandNameBox = Hive.box<BrandModal>('brandBox');
  await brandNameBox.add(BrandModal(brandName: brandName.trim()));
}

List<BrandModal> getAllBrands() {
  var box = Hive.box<BrandModal>('brandBox'); 
  return box.values.toList()..sort((a, b) => a.brandName.compareTo(b.brandName));
}

Future<void> updateBrand(dynamic key, String editedBrandName) async {
  final String trimmedBrandName = editedBrandName.trim();
  var brandNameBox = Hive.box<BrandModal>('brandBox');
  var productBox = Hive.box<ProductModal>('productBox');
  
  if (trimmedBrandName.isNotEmpty && brandNameBox.containsKey(key)) {
    // Get the old brand name before updating
    final oldBrandName = brandNameBox.get(key)?.brandName;
    
    if (oldBrandName != null && oldBrandName != trimmedBrandName) {
      // Update the brand
      await brandNameBox.put(key, BrandModal(brandName: trimmedBrandName));

      // Update all products that use this brand
      await Future.forEach(productBox.keys, (dynamic productKey) async {
        final product = productBox.get(productKey);
        if (product != null && product.productBrandName == oldBrandName) {
          final updatedProduct = ProductModal(
            itemName: product.itemName,
            productBrandName: trimmedBrandName,
            productCategory: product.productCategory,
            productQuantity: product.productQuantity,
            productPurchaseRate: product.productPurchaseRate,
            productSalesRate: product.productSalesRate,
            productMinimumQuantity: product.productMinimumQuantity,
            productSize: product.productSize,
            productColor: product.productColor,
            productImages: product.productImages,
          );
          await productBox.put(productKey, updatedProduct);
        }
      });
    }
  }
}

Future<void> deleteBrand(dynamic key) async {
  var brandNameBox = Hive.box<BrandModal>('brandBox');
  if (brandNameBox.containsKey(key)) {
    await brandNameBox.delete(key);
  }
}