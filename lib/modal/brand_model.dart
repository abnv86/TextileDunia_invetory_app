import 'package:hive_flutter/adapters.dart';

part 'brand_model.g.dart';

@HiveType(typeId: 1)
class BrandModal{
 @HiveField(0)
 final String brandName;

 BrandModal({
  required this.brandName, 
 });

}