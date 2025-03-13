import 'package:app/modal/user_password.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

String USERBOX = 'userbox';
final userBox = Hive.box<User>(USERBOX);

void addUser(User user) {
  userBox.put('user', user);
}

User? getUser() {
  if (!Hive.isBoxOpen(USERBOX)) {
    return null;
  }
  if (userBox.containsKey('user')) {
    User user = userBox.get('user')!;
    return user;
  } else {
    return null;
  }
}

void updateUserName(String newUserName) {
  if (userBox.containsKey('user')) {
    User oldUser = userBox.get('user')!;
    User updatedUser = User(
      userName: newUserName,
      password: oldUser.password,
      profileImage: oldUser.profileImage,
    );
    userBox.put('user', updatedUser);
  }
}

Future<void> updateUserProfileImage(String imagePath) async {
  if (userBox.containsKey('user')) {
    User oldUser = userBox.get('user')!;
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}${path.extension(imagePath)}';
    final savedImagePath = path.join(appDir.path, fileName);
    
    await File(imagePath).copy(savedImagePath);
    
  
    if (oldUser.profileImage != null) {
      try {
        await File(oldUser.profileImage!).delete();
      } catch (e) {
        // Ignore if file doesn't exist
      }
    }
    
    User updatedUser = User(
      userName: oldUser.userName,
      password: oldUser.password,
      profileImage: savedImagePath,
    );
    userBox.put('user', updatedUser);
  }
}



bool verifyCurrentPassword(String currentPassword) {
  if (userBox.containsKey('user')) {
    User user = userBox.get('user')!;
    return user.password == currentPassword;
  }
  return false;
}

void updateUserPassword(String newPassword) {
  if (userBox.containsKey('user')) {
    User oldUser = userBox.get('user')!;
    User updatedUser = User(
      userName: oldUser.userName,
      password: newPassword,
      profileImage: oldUser.profileImage,
    );
    userBox.put('user', updatedUser);
  }
}
