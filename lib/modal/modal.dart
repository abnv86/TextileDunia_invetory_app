
import 'package:hive_flutter/adapters.dart';

part 'modal.g.dart';

@HiveType(typeId: 0)
class Modal{
 @HiveField(0)
 late String title;

 @HiveField(1)
 late String description;

 @HiveField(2)
 late DateTime createdAt;
 
 @HiveField(3)
 late bool completed;

 Modal({
  required this.title,
  required this.description,
  required this.createdAt,
  required this.completed
 });

}