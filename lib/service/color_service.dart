import 'package:app/modal/color_modal.dart';
import 'package:app/modal/product_modal.dart';
import 'package:hive_flutter/adapters.dart';

void addColor(String addColorInHive) async {
  var addColorBox = Hive.box<ColorModal>('colorBox');
  await addColorBox.add(ColorModal(colorName: addColorInHive.trim()));
}

List<ColorModal> getAllColor() {
  var getBox = Hive.box<ColorModal>('colorBox');
  return getBox.values.toList()..sort((a, b) => a.colorName.compareTo(b.colorName));
}

Future<void> updateColor(dynamic key, String updatedColorName) async {
  final String trimmedColorName = updatedColorName.trim();
  var colorBox = Hive.box<ColorModal>('colorBox');
  var productBox = Hive.box<ProductModal>('productBox');

  if (trimmedColorName.isNotEmpty && colorBox.containsKey(key)) {
    // Get the old color name before updating
    final oldColorName = colorBox.get(key)?.colorName;
    
    if (oldColorName != null && oldColorName != trimmedColorName) {
      // Update the color
      await colorBox.put(key, ColorModal(colorName: trimmedColorName));

      // Update all products that use this color
      await Future.forEach(productBox.keys, (dynamic productKey) async {
        final product = productBox.get(productKey);
        if (product != null && product.productColor == oldColorName) {
          final updatedProduct = ProductModal(
            itemName: product.itemName,
            productBrandName: product.productBrandName,
            productCategory: product.productCategory,
            productQuantity: product.productQuantity,
            productPurchaseRate: product.productPurchaseRate,
            productSalesRate: product.productSalesRate,
            productMinimumQuantity: product.productMinimumQuantity,
            productSize: product.productSize,
            productColor: trimmedColorName,
            productImages: product.productImages,
          );
          await productBox.put(productKey, updatedProduct);
        }
      });
    }
  }
}

Future<void> deleteColor(dynamic key) async {
  var colorBox = Hive.box<ColorModal>('colorBox');
  if (colorBox.containsKey(key)) {
    await colorBox.delete(key);
  }
}