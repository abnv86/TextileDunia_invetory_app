import 'dart:io';
import 'package:app/screens/product_editing_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:app/modal/product_modal.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductModal product;
  final int productKey;

  const ProductDetailPage({
    super.key,
     required this.product,
     required this.productKey
    });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _selectedImageIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedImageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.product.productBrandName,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, ),
            onPressed: () => _confirmDelete(context),
          ),
          // In the actions section of the AppBar, update the edit IconButton:
IconButton(
  icon: const Icon(Icons.edit, size: 20),
  onPressed: () async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductEditingPage(
          product: widget.product,
          productKey: widget.productKey, // Make sure to add productKey as a parameter to ProductDetailPage
        ),
      ),
    );
    if (result == true) {
      // Refresh the page if product was updated
      setState(() {});
    }
  },
),

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
         color: Colors.grey[50],
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Product Details',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue,fontSize: 18),)
                    ],
                  ),
                  SizedBox(height: 10,),
                  Divider(color: Colors.blue[100]),
                  SizedBox(height: 10,),
                  // Product Image Gallery
                  SizedBox(
                    height: 300,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: widget.product.productImages.length,
                      onPageChanged: (index) {
                        setState(() {
                          _selectedImageIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 8.0,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(widget.product.productImages[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // const SizedBox(height: 30),
                  SizedBox(height: 10,),
                  // Divider(color: Colors.blue[100]),
                  SizedBox(height: 10,),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Rate: ₹ ${widget.product.productSalesRate}',
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  // Divider(color: Colors.blue[100]),
                  const SizedBox(height: 20),
                  buildDetailRow('Item name', widget.product.itemName.toString()),
                  buildDetailRow('Brand Name', widget.product.productBrandName),
                  buildDetailRow('Category', widget.product.productCategory),
                  buildDetailRow('Purchase Rate', '₹ ${widget.product.productPurchaseRate}'),
                  buildDetailRow('Sales Rate', '₹ ${widget.product.productSalesRate}'),
                  buildDetailRow('Quantity', widget.product.productQuantity.toString()),
                  buildDetailRow('Color', widget.product.productColor.toString()),
                  buildDetailRow('Size', widget.product.productSize.toString()),
                  buildDetailRow('Minimum Quantity for Alert', widget.product.productMinimumQuantity.toString()),
                 
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Product'),
        content: const Text('Are you sure you want to delete this product?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel',style: TextStyle(color: Colors.black),),
          ),
          TextButton(
            onPressed: () {
              _deleteProduct();
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteProduct() async {
    var box = Hive.box<ProductModal>('productBox');
    int? productKey;
    
    for (var key in box.keys) {
      if (box.get(key) == widget.product) {
        productKey = key;
        break;
      }
    }

    if (productKey != null) {
      await box.delete(productKey);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product deleted successfully!')),
      );
      if (mounted) {
        Navigator.pop(context);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product not found!')),
      );
    }
  }

  Widget buildDetailRow(String label, String value) {
    return Card(
      elevation: 2.0,
      
      color: Colors.grey[50],
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              value,
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}