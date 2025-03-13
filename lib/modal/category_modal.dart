

import 'package:hive_flutter/hive_flutter.dart';

part 'category_modal.g.dart';

@HiveType(typeId: 2)
class CategoryModal {

  @HiveField(0)
  final String categoryName;

  CategoryModal({required this.categoryName});
}