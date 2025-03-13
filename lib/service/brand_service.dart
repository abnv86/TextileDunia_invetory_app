// import 'package:app/modal/brand_modal.dart';
import 'package:app/modal/brand_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

void addBrand(String brandName) async {
  var brandNameBox = Hive.box<BrandModal>('brandBox');
  await brandNameBox.add(BrandModal(brandName: brandName));
}

List<BrandModal> getAllBrands() {
  var box = Hive.box<BrandModal>('brandBox'); 
  return box.values.toList(); 
}

Future<void> updateBrand(dynamic key, String editedBrandName) async {
  final String trimmedBrandName = editedBrandName.trim();
  var brandNameBox = Hive.box<BrandModal>('brandBox');
  
  if (trimmedBrandName.isNotEmpty) {
    if (brandNameBox.containsKey(key)) {
      final updatedBrand = BrandModal(brandName: trimmedBrandName);
      await brandNameBox.put(key, updatedBrand);
    }
  }
}
