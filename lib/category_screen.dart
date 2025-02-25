import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category',style: TextStyle(fontSize: 18),),centerTitle: true,
        leading: IconButton(onPressed: (){
         Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new,size: 18,)),
      ),
      body: Center(
        child: ElevatedButton(onPressed: (){

        }, child: Text('Add Category',style: TextStyle(color: Colors.black),)),
      ),
    );
  }
}