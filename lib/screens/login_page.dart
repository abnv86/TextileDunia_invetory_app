
import 'package:app/screens/bottom_navigation.dart';
import 'package:app/modal/user_password.dart';
import 'package:app/service/user_service.dart';
import 'package:flutter/material.dart';

final _formKey =GlobalKey<FormState>();

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});
  
  final _userNameController =TextEditingController();
  final _passwordController = TextEditingController();
   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child:Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _userNameController,
                    decoration: InputDecoration(
                      
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.black
                        )
                      ) ,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.grey
                        )
                      ),
                      errorBorder:OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(20)
                        ),
                      hintText: 'Enter User Name',hintStyle: TextStyle(color: Colors.grey,fontSize: 15)
                    
                    ),
                    validator: (value){
                      if(value==null||value.trim().isEmpty){
                        return" User name can't be empty";
                      }
                      return null;
                    },
                  ),
                 
                   SizedBox(height: 20,),
                    TextFormField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: InputDecoration(
                      
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.black
                          )
                        ) ,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.grey
                          ),
                          
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(20)
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(20)
                        ),
                        hintText: 'Enter Password',hintStyle: TextStyle(color: Colors.grey,fontSize: 15)
                      
                      ),
                      validator: (value) {
                        if(value==null||value.trim().isEmpty){
                          return "Paassword can't be empty";
                        }
                        if(value.length<6){
                          return "Password must be atleast 6 characters";
                        }
                      },
                    ),
                  SizedBox(height: 10,),
                  ElevatedButton(onPressed: (){
                    if(_formKey.currentState!.validate()){
                      final user =User(userName: _userNameController.text.trim(), password: _passwordController.text.trim());
                      addUser(user);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                      return Homepage();
                    }));
                    }
                    
                   },
                   style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF1F2F33,),minimumSize: Size(100, 40),
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),),
                  ), child: Text('LogIn',style: TextStyle(color: Colors.white),)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}