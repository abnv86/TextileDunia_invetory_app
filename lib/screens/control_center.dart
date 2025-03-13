import 'package:app/screens/add_products.dart';
import 'package:app/screens/brand.dart';
import 'package:app/screens/category_screen.dart';
import 'package:app/screens/color_screen.dart';
import 'package:app/screens/notification.dart';
import 'package:app/screens/other_expense.dart';
import 'package:app/screens/product_detail_page.dart';
import 'package:app/service/brand_service.dart';
import 'package:app/service/color_service.dart';
import 'package:flutter/material.dart';

class ControlCenter extends StatefulWidget {
  const ControlCenter({super.key});

  @override
  State<ControlCenter> createState() => _ControlCenterState();
}

class _ControlCenterState extends State<ControlCenter> {
  final List<Map<String, dynamic>> _controlOptions = [
   
    {
      'title': 'Add new products',
      'icon': Icons.add_box_outlined,
      'color': Colors.green,
      'destination': AddProducts(),
    },
    {
      'title': 'Sales History',
      'icon': Icons.history,
      'color': Colors.purple,
      'destination': AddProducts(), 
    },
    {
      'title': 'Other expenses',
      'icon': Icons.money_off_outlined,
      'color': Colors.red,
      'destination': OtherExpense(),
    },
    {
      'title': 'Category',
      'icon': Icons.category_outlined,
      'color': Colors.orange,
      'destination': CategoryScreen(),
    },
    {
      'title': 'Add colors',
      'icon': Icons.color_lens_outlined,
      'color': Colors.pink,
      'destination': ColorScreen(),
    },
    {
      'title': 'Add brand name',
      'icon': Icons.branding_watermark_outlined,
      'color': Colors.teal,
      'destination': BrandName(),
    },
    {
      'title': 'Dashboard',
      'icon': Icons.dashboard_outlined,
      'color': Colors.indigo,
      'destination': NotificationScreen(), 
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Control Center',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.1),
        
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return NotificationScreen();
              }));
            },
            icon: Icon(Icons.notifications_active_outlined, color: Colors.black),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.25,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: _controlOptions.length,
                  itemBuilder: (context, index) {
                    final option = _controlOptions[index];
                    return _buildOptionCard(
                      title: option['title'],
                      icon: option['icon'],
                      color: option['color'],
                      destination: option['destination'],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    required String title,
    required IconData icon,
    required Color color,
    required Widget destination,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return destination;
        }));
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withOpacity(0.8),
              color.withOpacity(0.6),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}