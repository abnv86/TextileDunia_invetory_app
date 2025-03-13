import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Notifications',style: TextStyle(fontSize: 18),),centerTitle: true,
        leading: IconButton(onPressed: (){
         Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new,size: 15,)),
      ),
    );
  }
}