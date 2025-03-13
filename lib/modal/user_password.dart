
import 'package:hive_flutter/adapters.dart';

part 'user_password.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  final String userName;

  @HiveField(1)
  final String password;

  @HiveField(2)
  final String? profileImage; 

  User({
    required this.userName,
    required this.password,
    this.profileImage,
  });
}
