import 'package:app/add_products.dart';
import 'package:app/category_screen.dart';
import 'package:app/more_screen.dart';
import 'package:app/notification.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
           return MoreScreen();
          }));
        }, icon: Icon(Icons.density_medium,size: 18,),),
        actions: [IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return NotificationScreen();
          },));
        }, icon: Icon(Icons.notifications_active_outlined,size: 20,),),],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
             SizedBox(height: 10,),
                   Container(
                    height: 40,
                     child: TextField(
                     
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search,size: 20,color: Colors.black,),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.black
                          )
                        ) ,
                          enabledBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.grey
                          )
                        ),
                        hintText: 'Search product',hintStyle: TextStyle(color: Colors.grey,fontSize: 15)
                      
                      ),
                                       ),
                   ),
                   SizedBox(height: 10,),
                   Container(
                  child:  ClipRRect(
              borderRadius: BorderRadius.circular(10),
         child:  Image.asset('images/cabinet.jpg'),   
           ),
                   )
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.production_quantity_limits_rounded),
             label: 'Products'),
               NavigationDestination(
            icon: IconButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                return AddProducts();
              }));
            }, icon: Icon(Icons.dashboard)),
             label: 'Dashboard'),
               NavigationDestination(
            icon: IconButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                return AddProducts();
              }));
            }, icon: Icon(Icons.add)),
             label: 'Add'),
               NavigationDestination(
            icon: IconButton(onPressed: (){
             Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return CategoryScreen();
             }));
            }, icon: Icon(Icons.category)),
             label: 'Category'),
               NavigationDestination(
            icon: Icon(Icons.account_circle_outlined),
             label: 'Account')
        ],        backgroundColor: Colors.white,
       ),
    );
  }
}