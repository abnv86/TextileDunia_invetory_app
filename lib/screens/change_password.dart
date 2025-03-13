import 'package:app/utilities/custom_widgets.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatelessWidget {
   ChangePassword({super.key});

   TextEditingController passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Change Password',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),centerTitle: true,
        leading: IconButton(onPressed: (){
         Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new,size: 18,)),
      ),
      body: Center(
        
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(hint: 'Enter current password',textEditingController: passwordController,)
            ],
          ),
        ),
      ),
      );
  }
}