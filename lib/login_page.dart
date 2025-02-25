import 'package:app/product_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  child: TextField(
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
                      hintText: 'Enter User Name',hintStyle: TextStyle(color: Colors.grey,fontSize: 15)
                    
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                  Container(
                  height: 40,
                  child: TextField(
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
                      hintText: 'Enter User Name',hintStyle: TextStyle(color: Colors.grey,fontSize: 15)
                    
                    ),
                  ),
                ),
                 SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: (){
                   Navigator.of(context).push(MaterialPageRoute(builder: (context){
                   return ProductScreen();
                   },
                   ));
                }, child: Text('Log In',style: TextStyle(color: Colors.black),))
              ],
            ),
          ),
        ),
      ),
    );
  }
}