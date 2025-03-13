import 'package:app/screens/notification.dart';
import 'package:app/utilities/custom_widgets.dart';
import 'package:flutter/material.dart';

class BillingPage extends StatelessWidget {
   BillingPage({super.key});

   TextEditingController customerNController= TextEditingController();
   TextEditingController customerPhController = TextEditingController();
   TextEditingController customerDateController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Billing',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),centerTitle: true,
       
      actions: [
        IconButton(onPressed: (){
      Navigator.of(context).push(MaterialPageRoute(builder:(context){
        return NotificationScreen();
      } ));
        }, icon: Icon(Icons.notifications_active_outlined,size: 20,))
      ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CustomTextField(hint: 'Customer Name',textEditingController: customerNController,),
              SizedBox(height: 10,),
              CustomTextField(hint: 'Customer Phone Number',textEditingController: customerPhController,),
               SizedBox(height: 10,),
               CustomTextField(hint: 'Date',textEditingController: customerDateController,),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                         Expanded(
                           child: TextField(
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
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
                                    hintText: 'Item name',hintStyle: TextStyle(color: Colors.grey,fontSize: 15)
                                  
                                  ),
                                             
                                ),
                         ),
                         SizedBox(width: 10,),

                  Expanded(child: CustomTextFieldForItems(width: 115, hint: 'Qty')),
                   SizedBox(width: 10,),
                  Expanded(child: CustomTextFieldForItems(width: 115, hint: 'Amount')),
                  ],
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
                    Text('Total Amount:'),
                    Text('2000')
                  ],
                )
            ],
          ),
        ),
      ),
      floatingActionButton: CustomElevatedButton(buttonName: 'Add Sales', title: 'Add to sales', tButtonOne: 'Cancel', tButtonTwo: 'Add'),
    );
  }
}