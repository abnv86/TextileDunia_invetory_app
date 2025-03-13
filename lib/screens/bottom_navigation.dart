import 'package:app/screens/control_center.dart';
import 'package:app/screens/customer_information.dart';
import 'package:app/screens/billing_page.dart';
import 'package:app/screens/product_page.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<Homepage> {

  int bottomIndex = 0;

  List<Widget> screens = [
    ProductPage(),
    BillingPage(),
     CustomerInformation(),
     ControlCenter(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: screens[bottomIndex],
      ), 
      
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF1F2F33),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: bottomIndex,
        onTap: (index) {
          setState(() {
            bottomIndex = index; 
          });
        },
        items: const [
          BottomNavigationBarItem(
             backgroundColor: Color(0xFF1F2F33),
            icon: Icon(Icons.shopping_bag_sharp),
            label: 'Product',
          ),
          BottomNavigationBarItem(
             backgroundColor: Color(0xFF1F2F33),
            icon: Icon(Icons.receipt),
            label: 'Billing',
          ),
          BottomNavigationBarItem(
             backgroundColor: Color(0xFF1F2F33),
            icon: Icon(Icons.people_alt),
            label: 'Customer',
          ),
          BottomNavigationBarItem(
             backgroundColor: Color(0xFF1F2F33),
            icon: Icon(Icons.tune),
            label: 'Control Center',
          ),
        ],
      ),
    );
  }
}
