import 'dart:ui';

import 'package:hive_flutter/hive_flutter.dart';

part 'color_modal.g.dart';

@HiveType(typeId: 4)
class ColorModal {
@HiveField(0)
String colorName;

ColorModal({
  required this.colorName
});

  get colorValue => null;
}