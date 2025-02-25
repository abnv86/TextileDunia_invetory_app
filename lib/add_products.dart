import 'package:flutter/material.dart';

class AddProducts extends StatelessWidget {
  const AddProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Items',style: TextStyle(fontSize: 18),),centerTitle: true,
        leading: IconButton(onPressed: (){
           Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new,size: 18,)),
      ),
      body: ListView(
        children: [
         Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
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
                              borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey
                            )
                          ),
                          hintText: 'Brand Name',hintStyle: TextStyle(color: Colors.grey,fontSize: 15)
                        
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
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
                              borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey
                            )
                          ),
                          hintText: 'Select Category',hintStyle: TextStyle(color: Colors.grey,fontSize: 15)
                        
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
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
                              borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey
                            )
                          ),
                          hintText: 'Item Barcode',hintStyle: TextStyle(color: Colors.grey,fontSize: 15)
                        
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
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
                              borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey
                            )
                          ),
                          hintText: 'Quantity',hintStyle: TextStyle(color: Colors.grey,fontSize: 15)
                        
                        ),
                      ),
                    ),
                     SizedBox(height: 10,),
                     Container(
                      height: 40,
                      child: TextField(
                        
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.money_off,color: Colors.black,),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Colors.black
                            )
                          ) ,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey
                            )
                          ),
                          hintText: 'Purchase Rate',hintStyle: TextStyle(color: Colors.grey,fontSize: 15)
                        
                        ),
                      ),
                    ),
                     SizedBox(height: 10,),
                     Container(
                      height: 40,
                      child: TextField(
                        decoration: InputDecoration(
                           suffixIcon: Icon(Icons.money_off,color: Colors.black,),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Colors.black
                            )
                          ) ,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey
                            )
                          ),
                          hintText: 'Sales Rate',hintStyle: TextStyle(color: Colors.grey,fontSize: 15)
                        
                        ),
                      ),
                    ),
                     SizedBox(height: 10,),
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
                              borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey
                            )
                          ),
                          hintText: 'Minimun Quantity For Alert',hintStyle: TextStyle(color: Colors.grey,fontSize: 15)
                        
                        ),
                      ),
                    ),
                     SizedBox(height: 10,),
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
                              borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey
                            )
                          ),
                          hintText: 'Add Description',hintStyle: TextStyle(color: Colors.grey,fontSize: 15)
                        
                        ),
                      ),
                    ),
                     SizedBox(height: 10,),
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
                              borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey
                            )
                          ),
                          hintText: 'Size',hintStyle: TextStyle(color: Colors.grey,fontSize: 15)
                        
                        ),
                      ),
                    ),
                     SizedBox(height: 10,),
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
                              borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey
                            )
                          ),
                          hintText: 'Colors',hintStyle: TextStyle(color: Colors.grey,fontSize: 15)
                        
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    SizedBox(
                      height: 200,
                      width: 400,
                      child: Card(
                        child: IconButton(onPressed: (){
                         
                        }, icon: Icon(Icons.add_a_photo_outlined)),
                      ),
                    ),
                    SizedBox(height: 10,),
                    ElevatedButton(onPressed: (){
        
                    }, child: Text('Add to Products',style: TextStyle(color: Colors.black),))
                    
        
              ],
            ),
          ),
        ),
        ],
      ),
    );
  }
}