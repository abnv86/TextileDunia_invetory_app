import 'package:app/modal/category_modal.dart';
import 'package:app/modal/product_modal.dart';
import 'package:hive_flutter/hive_flutter.dart';

void addCategory(String category) async {
  var categoryNameBox = Hive.box<CategoryModal>('categoryBox');
  await categoryNameBox.add(CategoryModal(categoryName: category.trim()));
}

List<CategoryModal> getAllCategory() {
  var box = Hive.box<CategoryModal>('categoryBox');
  return box.values.toList()..sort((a, b) => a.categoryName.compareTo(b.categoryName));
}

Future<void> updateCategory(dynamic key, String editedCategoryName) async {
  final String trimmedCategoryName = editedCategoryName.trim();
  var categoryNameBox = Hive.box<CategoryModal>('categoryBox');
  var productBox = Hive.box<ProductModal>('productBox');
  
  if (trimmedCategoryName.isNotEmpty && categoryNameBox.containsKey(key)) {
    // Get the old category name before updating
    final oldCategoryName = categoryNameBox.get(key)?.categoryName;
    
    if (oldCategoryName != null && oldCategoryName != trimmedCategoryName) {
      // Update the category
      await categoryNameBox.put(key, CategoryModal(categoryName: trimmedCategoryName));

      // Update all products that use this category
      await Future.forEach(productBox.keys, (dynamic productKey) async {
        final product = productBox.get(productKey);
        if (product != null && product.productCategory == oldCategoryName) {
          final updatedProduct = ProductModal(
            itemName: product.itemName,
            productBrandName: product.productBrandName,
            productCategory: trimmedCategoryName,
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

Future<void> deleteCategory(dynamic key) async {
  var categoryNameBox = Hive.box<CategoryModal>('categoryBox');
  if (categoryNameBox.containsKey(key)) {
    await categoryNameBox.delete(key);
  }
}