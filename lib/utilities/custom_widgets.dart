import 'package:flutter/material.dart';

//text field

class CustomTextField extends StatelessWidget {

  final String hint;
  final dynamic textEditingController;
  

  const CustomTextField({super.key, required this.hint, required this.textEditingController});
  
  
  @override
  Widget build(BuildContext context) {
    return 
     TextField(
      controller: textEditingController,
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
         hintText: hint,hintStyle: TextStyle(color: Colors.grey,fontSize: 15)
       
       ),
     );
  }
}

//text field with icon

class CustomTextFieldWithIcon extends StatelessWidget {
  final String hint;
  final IconData icon;

  const CustomTextFieldWithIcon({super.key, required this.hint, required this.icon});

  @override
  Widget build(BuildContext context) {
    return  TextField(
      decoration: InputDecoration(
        suffixIcon: Icon(icon,color: Colors.black,),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey),
        ),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
      ),
    );
  }
}

//elevated button with alert dialogue

class CustomElevatedButton extends StatelessWidget {
  final String buttonName;
  final String title;
  final String tButtonOne;
  final String tButtonTwo;

  const CustomElevatedButton({super.key, required this.buttonName,required this.title, required this.tButtonOne, required this.tButtonTwo});
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){
     alertDialogue(context,title,tButtonOne,tButtonTwo);
    },
      style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF1F2F33,),minimumSize: Size(350, 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),),
      ), child: Text(buttonName,style: TextStyle(color: Colors.white),));
  }
}


void alertDialogue(BuildContext context,String title,String tButtonOne,String tButtonTwo ){
 showDialog(context: context, builder: (BuildContext context){
  return AlertDialog(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
   title: Text(title,style: TextStyle(fontSize: 18),),
   actions: [
    TextButton(onPressed: (){
        Navigator.pop(context);
    }, child: Text(tButtonOne,style: TextStyle(color: Colors.red),),
    ),
    TextButton(onPressed: (){
         Navigator.pop(context);
    }, child: Text(tButtonTwo,style: TextStyle(color: Colors.black),))
   ],
  );
 });
}



//elevated button with alert dialogue and content

class CustomElevatedButtonTwo extends StatelessWidget {
  final String buttonName;
  final String title;
  final String contents;
  final String tButtonOne;
  final String tButtonTwo;

  const CustomElevatedButtonTwo({super.key, required this.buttonName,required this.title, required this.contents, required this.tButtonOne, required this.tButtonTwo});
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){
     alertDialogueTwo(context,title,contents,tButtonOne,tButtonTwo);
    },
      style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF1F2F33,),minimumSize: Size(350, 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),),
      ), child: Text(buttonName,style: TextStyle(color: Colors.white),));
  }
}


void alertDialogueTwo(BuildContext context,String title,String contents,String tButtonOne,String tButtonTwo ){
 showDialog(context: context, builder: (BuildContext context){
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
   title: Text(title),
   content: Container(
    height: 100,
    child:Column(
       children: [
      // CustomTextField(hint: contents ,textEditingController: ,),
      SizedBox(height: 10,),
      SizedBox(
        height: 80,
        width: 300,
        child: Card(
          child: Text('nfkfdk'),
        ),
      )
       ]
    )
   ),
   actions: [
    TextButton(onPressed: (){
        Navigator.pop(context);
    }, child: Text(tButtonOne,style: TextStyle(color: Colors.red),),
    ),
    TextButton(onPressed: (){
         Navigator.pop(context);
    }, child: Text(tButtonTwo,style: TextStyle(color: Colors.black),))
   ],
  );
 });
}


class CustomTextButton extends StatelessWidget {
    final String text;
    final Widget functionName;

  const CustomTextButton({super.key, required this.text,required this.functionName});
  

  @override
  Widget build(BuildContext context) {
    return   TextButton(style: TextButton.styleFrom(
        fixedSize: Size(350, 20),
              backgroundColor: Colors.white,
              foregroundColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
            ),
              onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                return  functionName;
              }));
            }, child: Text(text,style: TextStyle(color: Colors.black,fontSize: 15),));
  }
}

class CustomTextFieldForItems extends StatelessWidget {
  final double width;
  final String hint;

  const CustomTextFieldForItems({super.key, required this.width, required this.hint});

  @override
  Widget build(BuildContext context) {
    return  TextField(
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
        hintText: hint,hintStyle: TextStyle(color: Colors.grey,fontSize: 15)
      
      ),
    );
  }
}


class ElevatedButtonThree extends StatelessWidget {
 final String functionName;
 final String buttonName;
 final double width;

  const ElevatedButtonThree({super.key, required this.functionName, required this.buttonName, required this.width});
 
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){
     functionName;
    },
      style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF1F2F33,),minimumSize: Size(width, 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),),
      ), child: Text(buttonName,style: TextStyle(color: Colors.white),));
  }
  }
