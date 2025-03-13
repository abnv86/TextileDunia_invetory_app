import 'package:app/modal/brand_model.dart';
import 'package:app/service/brand_service.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BrandName extends StatefulWidget {
  const BrandName({super.key});

  @override
  State<BrandName> createState() => _BrandNameState();
}

class _BrandNameState extends State<BrandName> {
  final Box<BrandModal> _brandBox = Hive.box<BrandModal>('brandBox');

  final GlobalKey<FormState> brandKey = GlobalKey<FormState>();
   final GlobalKey<FormState> brandEditKey = GlobalKey<FormState>();
  List<BrandModal> brands = [];

  @override
  void initState() {
    super.initState();
    _loadBrands();
  }

  void _loadBrands() {
    setState(() {
      brands = _brandBox.values.toList();
    });
  }

  void _addBrand(String brandName) async {
    
  String trimmedBrandName = brandName.trim();
  if (trimmedBrandName.isNotEmpty) {
    await _brandBox.add(BrandModal(brandName: trimmedBrandName));
    _loadBrands();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Brand added successfully'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}

  void _updateBrandName(dynamic key, String editedBrandName) async {
  String trimmedBrandName = editedBrandName.trim();
  if (trimmedBrandName.isNotEmpty) {
    final brand = _brandBox.get(key);
    if (brand != null) {
      final updatedBrand = BrandModal(brandName: trimmedBrandName);
      await _brandBox.put(key, updatedBrand);
      _loadBrands();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Brand updated successfully'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }
}

  void _showBrandDialog(BuildContext context) {
    TextEditingController _brandController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: const Text('Add New Brand', style: TextStyle(fontSize: 20)),
          content: Form(
            key: brandKey,
            child: TextFormField(
              controller: _brandController,
             decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    hintText: 'Brand name',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Brand name cannot be empty'; // Required field validation
                    }
                    return null; // No error if input is valid
                  },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                 if (brandKey.currentState!.validate()) {
                  _addBrand(_brandController.text);
                  Navigator.pop(context);
                }
              },
              child: const Text('Add', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  void _showBrandEditDialog(BuildContext context, dynamic key, String currentBrandName) {
    TextEditingController _brandEditController = TextEditingController(text: currentBrandName);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: const Text('Edit Brand Name', style: TextStyle(fontSize: 20)),
          content: Form(
            key: brandEditKey,
            child: TextFormField(
              controller: _brandEditController,
              decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    hintText: 'Enter new brand name',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Brand name cannot be empty'; // Required field validation
                    }
                    return null; // No error if input is valid
                  },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                // if (_brandEditController.text.trim().isNotEmpty) {
                //   _updateBrandName(key, _brandEditController.text);
                // }
                // Navigator.pop(context);

                if (brandEditKey.currentState!.validate()) {
                  _updateBrandName(key, _brandEditController.text);
                  Navigator.pop(context);
                }
              },
              child: const Text('Save', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Manage Brands', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, size: 15),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 80), // Added bottom padding to prevent overlap
              child: brands.isEmpty
                  ? const Center(child: Text("No brands added yet", style: TextStyle(fontSize: 16, color: Colors.grey)))
                  : ListView.builder(
                      itemCount: brands.length,
                      itemBuilder: (context, index) {
                        dynamic key = _brandBox.keyAt(index);
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0), // Added spacing between cards
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              title: Text(
                                brands[index].brandName,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  _showBrandEditDialog(context, key, brands[index].brandName);
                                },
                                icon: const Icon(Icons.edit, size: 20, color: Colors.blueGrey),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20), // Added padding to raise the button
        child: ElevatedButton(
          onPressed: () => _showBrandDialog(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1F2F33),
            minimumSize: const Size(350, 40),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
          child: const Text('Add Brand', style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
