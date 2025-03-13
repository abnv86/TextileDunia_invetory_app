// import 'dart:io';

// import 'package:image_picker/image_picker.dart';

// Future<File?> pickImage() async {
//   final ImagePicker picker = ImagePicker();
//   // Pick the image from the gallery.
//   final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  
//   // Convert the picked image to a File.
//   if (image != null) {
//     File file = File(image.path);
    
//     // Optional: If you want to persist the file in your app's documents directory,
//     // you could copy it to a permanent location like this:
//     //
//     // final directory = await getApplicationDocumentsDirectory();
//     // final String newPath = join(directory.path, basename(file.path));
//     // final File newFile = await file.copy(newPath);
//     // return newFile;
    
//     return file; // Returns the file directly from the gallery path.
//   }
  
//   return null;
// }
