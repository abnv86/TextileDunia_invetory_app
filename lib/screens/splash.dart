import 'package:app/screens/bottom_navigation.dart';
import 'package:app/screens/login_page.dart';
import 'package:app/modal/user_password.dart';
import 'package:app/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      _initializeHiveAndNavigate();
    });
  }

  void _initializeHiveAndNavigate() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserAdapter());
    }
    var userBox = await Hive.openBox<User>(USERBOX);
    await Future.delayed(Duration(seconds: 1));

    if (userBox.isNotEmpty) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Homepage()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(70.0),
            ),
            child: SizedBox(
              width: screenWidth,
              height: screenHeight * 0.35, // Reduced responsive height
              child: Image.asset(
                'images/4456381.jpg',
                fit: BoxFit.cover, // Cover the entire area
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.08, // Reduced responsive height for icon
            child: Image.asset(
              'images/t-shirt-icon.png',
              width: screenWidth * 0.10, // Reduced responsive width
            ),
          ),
          Container(
            height: screenHeight * 0.2, // Reduced responsive height for text
            alignment: Alignment.center,
            child: Text(
              'Texventory',
              style: TextStyle(
                fontSize: screenWidth * 0.04, // Reduced responsive font size
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}