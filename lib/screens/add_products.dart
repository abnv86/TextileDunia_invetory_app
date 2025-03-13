import 'dart:io';
import 'package:app/modal/brand_model.dart';
import 'package:app/modal/category_modal.dart';
import 'package:app/modal/color_modal.dart';
import 'package:app/modal/product_modal.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

class AddProducts extends StatefulWidget {
  AddProducts({super.key});

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  final GlobalKey<FormState> _formKeyAddProduct = GlobalKey<FormState>();
  final ValueNotifier<String?> selectedCategory = ValueNotifier<String?>(null);
  final ValueNotifier<String?> selectedBrand = ValueNotifier<String?>(null);
  final ValueNotifier<String?> selectedColor = ValueNotifier<String?>(null);

  late Box<CategoryModal> categoryBox;
  late Box<BrandModal> brandBox;
  late Box<ColorModal> colorBox;

  TextEditingController pruchaseTextEditingController = TextEditingController();
  TextEditingController salesRateController = TextEditingController();
  TextEditingController minimumQforAController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
   TextEditingController itemNameController = TextEditingController();

  final ValueNotifier<List<File>> selectedImages =
      ValueNotifier<List<File>>([]);

  Future<void> pickImages() async {
    final ImagePicker picker = ImagePicker();

    if (selectedImages.value.length >= 4) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('You can only select up to 4 images.'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    final List<XFile>? images = await picker.pickMultiImage();

    if (images != null && images.isNotEmpty) {
      int remainingSlots = 4 - selectedImages.value.length;

      List<File> newImages = images
          .take(remainingSlots) // Take only the allowed number of images
          .map((image) => File(image.path))
          .toList();

      // Update ValueNotifier properly
      selectedImages.value = List.from(selectedImages.value)..addAll(newImages);
    }
  }

  void _removeImage(int index) {
    selectedImages.value = List.from(selectedImages.value)..removeAt(index);
  }


  Future<void> _addProduct() async {
  if (_formKeyAddProduct.currentState!.validate()) {
    if (selectedImages.value.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one image!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final productBox = Hive.box<ProductModal>('productBox');

    if (!productBox.isOpen) {
      print("❌ Hive box is not open!");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Database is not open!')),
      );
      return;
    }

    print("✅ Hive box is open. Adding product...");

    List<String> imagePaths = selectedImages.value.map((img) => img.path).toList();
    ProductModal newProduct = ProductModal(
      itemName: itemNameController.text,
      productBrandName: selectedBrand.value ?? '',
      productCategory: selectedCategory.value ?? '',
      productQuantity: int.tryParse(quantityController.text) ?? 0,
      productPurchaseRate: int.tryParse(pruchaseTextEditingController.text) ?? 0,
      productSalesRate: int.tryParse(salesRateController.text) ?? 0,
      productMinimumQuantity: int.tryParse(minimumQforAController.text) ?? 0,
      productSize: sizeController.text,
      productColor: selectedColor.value ?? '',
      productImages: imagePaths,
    );

    await productBox.add(newProduct);

    print("🎉 Product Added! Total products: ${productBox.length}");

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Product Added Successfully!'),
        backgroundColor: Colors.green,
      ),
    );

    // Clear fields after adding
    itemNameController.clear();
    selectedCategory.value = null;
    selectedBrand.value = null;
    selectedColor.value = null;
    quantityController.clear();
    pruchaseTextEditingController.clear();
    salesRateController.clear();
    minimumQforAController.clear();
    sizeController.clear();
    selectedImages.value = [];

    if (mounted) setState(() {});
  }
}






  @override
  void initState() {
    super.initState();
    categoryBox = Hive.box<CategoryModal>('categoryBox');
    brandBox = Hive.box<BrandModal>('brandBox');
    colorBox = Hive.box<ColorModal>('colorBox');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Add Products',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new,
              size: 18, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            _buildProductForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductForm() {
    return Card(
      color: Colors.grey[50],
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKeyAddProduct,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Product Details',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              const SizedBox(height: 20),

               TextFormField(
                // Controller for managing input
                controller: itemNameController,
                // keyboardType:
                    // TextInputType.number, // Ensures only numbers are entered
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
                  hintText: 'Item name',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Item name cannot be  empty'; // Required field validation
                  }
                  return null; // No error if input is valid
                },
              ),

              SizedBox(height: 10,),
              // ✅ Dropdown for Brand Selection (Using ValueListenableBuilder)
              ValueListenableBuilder<Box<BrandModal>>(
                valueListenable: brandBox.listenable(),
                builder: (context, Box<BrandModal> box, _) {
                  List<String> brandNames =
                      box.values.map((brand) => brand.brandName).toList();

                  return ValueListenableBuilder<String?>(
                    valueListenable: selectedBrand,
                    builder: (context, value, _) {
                      return DropdownButtonFormField<String>(
                        value: value, // Use ValueNotifier's value
                        decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          hintText: 'Select Brand',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a brand';
                          }
                          return null;
                        },
                        items: brandNames.map((brand) {
                          return DropdownMenuItem(
                            value: brand,
                            child: Text(brand),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          selectedBrand.value = newValue;
                          _formKeyAddProduct.currentState!
                              .validate(); // Validate form when changed
                        },
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: 10),

              // ✅ Dropdown for Category Selection (Using ValueListenableBuilder)
              ValueListenableBuilder(
                valueListenable: categoryBox.listenable(),
                builder: (context, Box<CategoryModal> box, _) {
                  List<String> categories = box.values
                      .map((category) => category.categoryName)
                      .toList();

                  return ValueListenableBuilder<String?>(
                    valueListenable: selectedCategory,
                    builder: (context, value, _) {
                      return DropdownButtonFormField<String>(
                        value: value,
                        decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          hintText: 'Select category',
                        ),
                        items: categories.map((category) {
                          return DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          selectedCategory.value = newValue;
                          _formKeyAddProduct.currentState!.validate();
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a category';
                          }
                          return null;
                        },
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: 10),

              TextFormField(
                // Controller for managing input
                controller: quantityController,
                keyboardType:
                    TextInputType.number, // Ensures only numbers are entered
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
                  hintText: 'Quantity',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Quantity is required'; // Required field validation
                  }
                  if (int.tryParse(value) == null || int.parse(value) <= 0) {
                    return 'Enter a valid quantity'; // Ensures input is a positive integer
                  }
                  return null; // No error if input is valid
                },
              ),

              const SizedBox(height: 10),

              TextFormField(
                   keyboardType:
                    TextInputType.number, // Ensures only numbers are entered
                controller: pruchaseTextEditingController,
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
                  hintText: 'Purchase rate',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Purchase rate cannot be empty'; // Required field validation
                  }
                  return null; // No error if input is valid
                },
              ),
              SizedBox(
                height: 10,
              ),

              TextFormField(
                 keyboardType:
                    TextInputType.number, // Ensures only numbers are entered
                controller: salesRateController,
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
                  hintText: 'Sales rate',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Sales rate cannot be empty'; // Required field validation
                  }
                  if (int.tryParse(value) == null || int.parse(value) <= 0) {
                    return 'Enter a valid rate'; // Ensures input is a positive integer
                  }
                  return null; // No error if input is valid
                },
              ),
              SizedBox(
                height: 10,
              ),

              TextFormField(
                 keyboardType:
                    TextInputType.number, // Ensures only numbers are entered
                controller: minimumQforAController,
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
                  hintText: 'Minimum quantity for alert',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'cannot be empty'; // Required field validation
                  }
                  if (int.tryParse(value) == null || int.parse(value) <= 0) {
                    return 'Enter a valid number'; // Ensures input is a positive integer
                  }
                  return null; // No error if input is valid
                },
              ),
              const SizedBox(height: 10),
              // const SizedBox(height: 10),
              TextFormField(
                controller: sizeController,
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
                  hintText: 'size',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return ' size cannot be empty'; // Required field validation
                  }
                  return null; // No error if input is valid
                },
              ),
              const SizedBox(height: 10),

              ValueListenableBuilder(
                valueListenable: colorBox.listenable(),
                builder: (context, Box<ColorModal> box, _) {
                  List<String> colors =
                      box.values.map((color) => color.colorName).toList();

                  return ValueListenableBuilder<String?>(
                    valueListenable: selectedColor,
                    builder: (context, value, _) {
                      return DropdownButtonFormField<String>(
                        value: value,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Select color',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Color cannot be empty';
                          }
                          return null;
                        },
                        items: colors.map((color) {
                          return DropdownMenuItem(
                            value: color,
                            child: Text(color),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          selectedColor.value = newValue;
                          _formKeyAddProduct.currentState!.validate();
                        },
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white),
                  onPressed: () {
                    pickImages();
                  },
                  child: Text('Add product images')),
              SizedBox(
                height: 10,
              ),
              ValueListenableBuilder<List<File>>(
                valueListenable: selectedImages,
                builder: (context, images, _) {
                  return images.isEmpty
                      ? Text('No images selected')
                      : Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: List.generate(images.length, (index) {
                            return Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    images[index],
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () => _removeImage(index),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                      padding: EdgeInsets.all(5),
                                      child: Icon(Icons.close,
                                          size: 16, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                        );
                },
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    // if (_formKeyAddProduct.currentState!.validate()) {
                    //   // updateCategory(key, _categoryNameController.text);
                    //   // Navigator.pop(context);
                    // }
                    _addProduct();
                    print('button presssed');
                  },
                   style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF1F2F33,),minimumSize: Size(350, 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),),
      ), child: Text('Add product',style: TextStyle(color: Colors.white),)
                  
                  )
            ],
          ),
        ),
      ),
    );
  }
}
