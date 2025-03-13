// category_service.dart
import 'package:app/modal/category_modal.dart';
import 'package:hive_flutter/hive_flutter.dart';

void addCategory(String category) async {
  var categoryNameBox = Hive.box<CategoryModal>('categoryBox');
  await categoryNameBox.add(CategoryModal(categoryName: category));
}

List<CategoryModal> getAllCategory() {
  var box = Hive.box<CategoryModal>('categoryBox');
  return box.values.toList();
}

void updateCategory(dynamic key, String editedCategoryName) async {
  final String trimmedCategoryName = editedCategoryName.trim();
  var categoryNameBox = Hive.box<CategoryModal>('categoryBox');
  
  if (trimmedCategoryName.isNotEmpty) {
    if (categoryNameBox.containsKey(key)) {
      final updatedCategory = CategoryModal(categoryName: trimmedCategoryName);
      await categoryNameBox.put(key, updatedCategory);
    }
  }
}
