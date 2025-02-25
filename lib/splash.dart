import 'package:app/login_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3),(){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
        return LoginScreen();
      },));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SafeArea(child: Column(
        children: [
          Stack(
            children: [
           ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(70.0), // Only top-left corner rounded
              ),
         child:  Image.asset('images/4456381.jpg'),   
           ),
            
          SizedBox(height: 180,),
          Icon(Icons.shopping_cart_checkout,size: 40,),
           SizedBox(height: 250,),
          Text('TEXTILE DUNIYA',style: TextStyle(fontSize: 12,),),
        ],
        ),
        ],
      ),)
    );
  }
}