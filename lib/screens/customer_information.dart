import 'package:app/utilities/custom_widgets.dart';
import 'package:flutter/material.dart';

class CustomerInformation extends StatelessWidget {
   CustomerInformation({super.key});

   TextEditingController customerPhoneNumberController = TextEditingController();
    TextEditingController customerNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
         title: Text('Customer Information',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),centerTitle: true,
        actions: [
          IconButton(onPressed: (){

          }, icon: Icon(Icons.notifications_active_outlined,size: 20,))
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CustomTextField(hint: 'Customer Name',textEditingController: customerNameController,),
              SizedBox(height: 10,),
              CustomTextField(hint: 'Customer Phone Number',textEditingController: customerPhoneNumberController,)
            ],
          ),
        ),
    
      ),
      floatingActionButton: CustomElevatedButton(buttonName: 'Add', title: 'Add customer information', tButtonOne: 'Cancel', tButtonTwo: 'Add'),
    );
  }
}