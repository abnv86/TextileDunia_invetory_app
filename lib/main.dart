// import 'package:app/modal/brand_modal.dart';
import 'package:app/modal/brand_model.dart';
import 'package:app/modal/category_modal.dart';
import 'package:app/modal/color_modal.dart';
import 'package:app/modal/product_modal.dart';
import 'package:app/modal/user_password.dart';
import 'package:app/service/user_service.dart';
import 'package:app/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main()async{
WidgetsFlutterBinding.ensureInitialized();

 await Hive.initFlutter();
 Hive.registerAdapter(UserAdapter());
 await Hive.openBox<User>(USERBOX); 
 Hive.registerAdapter(BrandModalAdapter());
 await Hive.openBox<BrandModal>('brandBox');
 Hive.registerAdapter(CategoryModalAdapter());
 await Hive.openBox<CategoryModal>('categoryBox');
 Hive.registerAdapter(ColorModalAdapter());
 await Hive.openBox<ColorModal>('colorBox');
 Hive.registerAdapter(ProductModalAdapter());
 await Hive.openBox<ProductModal>('productBox');

//  await Hive.deleteFromDisk(); // ⚠️ Deletes ALL Hive data

 
 
runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}