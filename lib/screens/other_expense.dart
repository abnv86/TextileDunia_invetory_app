import 'package:app/utilities/custom_widgets.dart';
import 'package:flutter/material.dart';

class OtherExpense extends StatelessWidget {
   OtherExpense({super.key});

  TextEditingController expenceController=TextEditingController();
  TextEditingController amountController=TextEditingController();

   void alertDialogueBrand(BuildContext context){
 showDialog(context: context, builder: (BuildContext context){
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
   title: Text('Add Other Expense',style: TextStyle(fontSize: 20),),
   content: Container(
    height: 90,
    width: 300,
    child:Column(
       children: [
      CustomTextField(hint: 'Enter expense category',textEditingController: expenceController,),
      SizedBox(height: 10,),
      CustomTextField(hint: 'Enter Amount',textEditingController: amountController,),
       ]
    )
   ),
   actions: [
    TextButton(onPressed: (){
        Navigator.pop(context);
    }, child: Text('Cancel',style: TextStyle(color: Colors.red),),
    ),
    TextButton(onPressed: (){
         Navigator.pop(context);
    }, child: Text('Add',style: TextStyle(color: Colors.black),))
   ],
  );
 });
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Add Other Expense',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),centerTitle: true,
        leading: IconButton(onPressed: (){
        Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new,size: 15,)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child:ListView(
            children: [
              SizedBox(
              height: 70,
              
              child: Card(
                color: Color(0xFFFCF7F8),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                   SizedBox(width: 120,),
                    Text('Expense',
                    textAlign: TextAlign.center, 
                    style: TextStyle(fontSize: 17,
                     fontWeight: FontWeight.w300,),),
                     SizedBox(width: 60,),
                     IconButton(onPressed: (){
                         alertDialogueBrand(context);
                     }, icon: Icon(Icons.edit,size: 17,))
                  ],
                ) ,
              ),
            )
             
            ],
            
          ),
          
        ),
        
      ),
      
      floatingActionButton:   ElevatedButton(onPressed: (){
     alertDialogueBrand(context);
    },
      style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF1F2F33,),minimumSize: Size(350, 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),),
      ), child: Text('Add Expense',style: TextStyle(color: Colors.white),)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      
    );
  }
}