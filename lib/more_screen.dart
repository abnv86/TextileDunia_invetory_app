import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('More',style: TextStyle(fontSize: 18),),centerTitle: true,
        leading: IconButton(onPressed: (){
        Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new,size: 18,)),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: (){

            }, child: Text('Import Data',style: TextStyle(color: Colors.black),)),
             ElevatedButton(onPressed: (){

            }, child: Text('Add Sales',style: TextStyle(color: Colors.black),)),
              ElevatedButton(onPressed: (){

            }, child: Text('Sales History',style: TextStyle(color: Colors.black),)),
              ElevatedButton(onPressed: (){

            }, child: Text('Add Sales Order',style: TextStyle(color: Colors.black),)),
              ElevatedButton(onPressed: (){

            }, child: Text('Sales Order History',style: TextStyle(color: Colors.black),)),
              ElevatedButton(onPressed: (){

            }, child: Text('Other Expenses',style: TextStyle(color: Colors.black),)),
              ElevatedButton(onPressed: (){

            }, child: Text('Customer Information',style: TextStyle(color: Colors.black),))
          ],
        ),
      ),
    );
  }
}