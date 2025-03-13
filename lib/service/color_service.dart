import 'package:app/modal/color_modal.dart';
import 'package:hive_flutter/adapters.dart';

// Add a new color to Hive
void addColor(String addColorInHive) async {
  var addColorBox = Hive.box<ColorModal>('colorBox');
  await addColorBox.add(ColorModal(colorName: addColorInHive));
}

// Get all colors from Hive
List<ColorModal> getAllColor() {
  var getBox = Hive.box<ColorModal>('colorBox');
  return getBox.values.toList();
}

// Update a color in Hive
Future<void> updateColor(int key, String updatedColorName) async {
  var updateColorBox = Hive.box<ColorModal>('colorBox');
  if (updateColorBox.containsKey(key)) {
    final updatedColor = ColorModal(colorName: updatedColorName);
    await updateColorBox.put(key, updatedColor);
  }
}

// Delete a color from Hive
Future<void> deleteColor(int key) async {
  var deleteColorBox = Hive.box<ColorModal>('colorBox');
  if (deleteColorBox.containsKey(key)) {
    await deleteColorBox.delete(key);
  }
}