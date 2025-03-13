import 'dart:io';
import 'package:app/modal/brand_model.dart';
import 'package:app/modal/category_modal.dart';
import 'package:app/modal/color_modal.dart';
import 'package:app/modal/product_modal.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ProductEditingPage extends StatefulWidget {
  final ProductModal product;
  final int productKey;

  const ProductEditingPage({
    Key? key,
    required this.product,
    required this.productKey,
  }) : super(key: key);

  @override
  State<ProductEditingPage> createState() => _ProductEditingPageState();
}

class _ProductEditingPageState extends State<ProductEditingPage> {
  final GlobalKey<FormState> _formKeyEditProduct = GlobalKey<FormState>();
  late TextEditingController itemNameController;
  late TextEditingController pruchaseTextEditingController;
  late TextEditingController salesRateController;
  late TextEditingController minimumQforAController;
  late TextEditingController sizeController;
  late TextEditingController quantityController;
  
  late Box<CategoryModal> categoryBox;
  late Box<BrandModal> brandBox;
  late Box<ColorModal> colorBox;
  late Box<ProductModal> productBox;
  
  final ValueNotifier<List<File>> selectedImages = ValueNotifier<List<File>>([]);
  final ValueNotifier<String?> selectedCategory = ValueNotifier<String?>(null);
  final ValueNotifier<String?> selectedBrand = ValueNotifier<String?>(null);
  final ValueNotifier<String?> selectedColor = ValueNotifier<String?>(null);

  @override
  void initState() {
    super.initState();
    
    // Initialize boxes
    categoryBox = Hive.box<CategoryModal>('categoryBox');
    brandBox = Hive.box<BrandModal>('brandBox');
    colorBox = Hive.box<ColorModal>('colorBox');
    productBox = Hive.box<ProductModal>('productBox');
    
    // Initialize controllers with existing data
    itemNameController = TextEditingController(text: widget.product.itemName);
    pruchaseTextEditingController = TextEditingController(text: widget.product.productPurchaseRate.toString());
    salesRateController = TextEditingController(text: widget.product.productSalesRate.toString());
    minimumQforAController = TextEditingController(text: widget.product.productMinimumQuantity.toString());
    sizeController = TextEditingController(text: widget.product.productSize);
    quantityController = TextEditingController(text: widget.product.productQuantity.toString());
    
    // Initialize selected values
    selectedCategory.value = widget.product.productCategory;
    selectedBrand.value = widget.product.productBrandName;
    selectedColor.value = widget.product.productColor;
    
    // Initialize images
    selectedImages.value = widget.product.productImages.map((path) => File(path)).toList();

    // Add listeners to boxes for real-time updates
    categoryBox.listenable().addListener(_updateCategoryIfNeeded);
    brandBox.listenable().addListener(_updateBrandIfNeeded);
    colorBox.listenable().addListener(_updateColorIfNeeded);
  }

  void _updateCategoryIfNeeded() {
    final categories = categoryBox.values.map((cat) => cat.categoryName).toList();
    if (!categories.contains(selectedCategory.value)) {
      // If the current category no longer exists, reset it
      selectedCategory.value = categories.isNotEmpty ? categories.first : null;
    }
  }

  void _updateBrandIfNeeded() {
    final brands = brandBox.values.map((brand) => brand.brandName).toList();
    if (!brands.contains(selectedBrand.value)) {
      // If the current brand no longer exists, reset it
      selectedBrand.value = brands.isNotEmpty ? brands.first : null;
    }
  }

  void _updateColorIfNeeded() {
    final colors = colorBox.values.map((color) => color.colorName).toList();
    if (!colors.contains(selectedColor.value)) {
      // If the current color no longer exists, reset it
      selectedColor.value = colors.isNotEmpty ? colors.first : null;
    }
  }

  @override
  void dispose() {
    itemNameController.dispose();
    pruchaseTextEditingController.dispose();
    salesRateController.dispose();
    minimumQforAController.dispose();
    sizeController.dispose();
    quantityController.dispose();
    selectedCategory.dispose();
    selectedBrand.dispose();
    selectedColor.dispose();
    selectedImages.dispose();
    super.dispose();
  }

  Future<void> pickImages() async {
    final ImagePicker picker = ImagePicker();

    if (selectedImages.value.length >= 4) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
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
          .take(remainingSlots)
          .map((image) => File(image.path))
          .toList();
      selectedImages.value = List.from(selectedImages.value)..addAll(newImages);
    }
  }

  void _removeImage(int index) {
    selectedImages.value = List.from(selectedImages.value)..removeAt(index);
  }

  Future<void> _updateProduct() async {
    if (_formKeyEditProduct.currentState!.validate()) {
      if (selectedImages.value.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select at least one image!'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      try {
        List<String> imagePaths = selectedImages.value.map((img) => img.path).toList();
        
        ProductModal updatedProduct = ProductModal(
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

        await productBox.put(widget.productKey, updatedProduct);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Product Updated Successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context, true);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error updating product: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Edit Product',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: Colors.black,
          ),
        ),
      ),
      body: ValueListenableBuilder<Box<CategoryModal>>(
        valueListenable: categoryBox.listenable(),
        builder: (context, categoryBoxValue, _) {
          return ValueListenableBuilder<Box<BrandModal>>(
            valueListenable: brandBox.listenable(),
            builder: (context, brandBoxValue, _) {
              return ValueListenableBuilder<Box<ColorModal>>(
                valueListenable: colorBox.listenable(),
                builder: (context, colorBoxValue, _) {
                  final categories = categoryBoxValue.values
                      .map((cat) => cat.categoryName)
                      .toList()..sort();
                  final brands = brandBoxValue.values
                      .map((brand) => brand.brandName)
                      .toList()..sort();
                  final colors = colorBoxValue.values
                      .map((color) => color.colorName)
                      .toList()..sort();

                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: ListView(
                      children: [
                        Card(
                          color: Colors.grey[50],
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Form(
                              key: _formKeyEditProduct,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Edit Product Details',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue
                                    ),
                                  ),
                                  const SizedBox(height: 20),

                                  // Item Name Field
                                  TextFormField(
                                    controller: itemNameController,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(color: Colors.black),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(color: Colors.grey),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(color: Colors.red),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(color: Colors.red),
                                      ),
                                      hintText: 'Item name',
                                      hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Item name cannot be empty';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 10),

                                  // Brand Selection
                                  ValueListenableBuilder<String?>(
                                    valueListenable: selectedBrand,
                                    builder: (context, selectedBrandValue, _) {
                                      return DropdownButtonFormField<String>(
                                        value: brands.contains(selectedBrandValue) 
                                            ? selectedBrandValue 
                                            : (brands.isNotEmpty ? brands.first : null),
                                        decoration: InputDecoration(
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.red),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.red),
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
                                        items: brands.map((brand) {
                                          return DropdownMenuItem(
                                            value: brand,
                                            child: Text(brand),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          if (value != null) {
                                            selectedBrand.value = value;
                                          }
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please select a brand';
                                          }
                                          return null;
                                        },
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 10),

                                  // Category Selection
                                  ValueListenableBuilder<String?>(
                                    valueListenable: selectedCategory,
                                    builder: (context, selectedCategoryValue, _) {
                                      return DropdownButtonFormField<String>(
                                        value: categories.contains(selectedCategoryValue) 
                                            ? selectedCategoryValue 
                                            : (categories.isNotEmpty ? categories.first : null),
                                        decoration: InputDecoration(
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.red),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.red),
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
                                          hintText: 'Select Category',
                                        ),
                                        items: categories.map((category) {
                                          return DropdownMenuItem(
                                            value: category,
                                            child: Text(category),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          if (value != null) {
                                            selectedCategory.value = value;
                                          }
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please select a category';
                                          }
                                          return null;
                                        },
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 10),

                                  // Quantity Field
                                  TextFormField(
                                    controller: quantityController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(color: Colors.black),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(color: Colors.grey),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(color: Colors.red),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(color: Colors.red),
                                      ),
                                      hintText: 'Quantity',
                                      hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Quantity is required';
                                      }
                                      if (int.tryParse(value) == null || int.parse(value) <= 0) {
                                        return 'Enter a valid quantity';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 10),

                                  // Purchase Rate Field
                                  TextFormField(
                                    controller: pruchaseTextEditingController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(color: Colors.black),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(color: Colors.grey),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(color: Colors.red),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(color: Colors.red),
                                      ),
                                      hintText: 'Purchase rate',
                                      hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Purchase rate cannot be empty';
                                      }
                                      if (int.tryParse(value) == null || int.parse(value) <= 0) {
                                        return 'Enter a valid rate';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 10),

                                  // Sales Rate Field
                                  TextFormField(
                                    controller: salesRateController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(color: Colors.black),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(color: Colors.grey),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(color: Colors.red),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(color: Colors.red),
                                      ),
                                      hintText: 'Sales rate',
                                      hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Sales rate cannot be empty';
                                      }
                                      if (int.tryParse(value) == null || int.parse(value) <= 0) {
                                        return 'Enter a valid rate';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 10),

                                  // Minimum Quantity Alert Field
                                  TextFormField(
                                    controller: minimumQforAController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(color: Colors.black),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(color: Colors.grey),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(color: Colors.red),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(color: Colors.red),
                                      ),
                                      hintText: 'Minimum quantity for alert',
                                      hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Minimum quantity cannot be empty';
                                      }
                                      if (int.tryParse(value) == null || int.parse(value) <= 0) {
                                        return 'Enter a valid number';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 10),

                                  // Size Field
                                  TextFormField(
                                    controller: sizeController,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(color: Colors.black),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(color: Colors.grey),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(color: Colors.red),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(color: Colors.red),
                                      ),
                                      hintText: 'Size',
                                      hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Size cannot be empty';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 10),

                                  // Color Selection
                                  ValueListenableBuilder<String?>(
                                    valueListenable: selectedColor,
                                    builder: (context, selectedColorValue, _) {
                                      return DropdownButtonFormField<String>(
                                        value: colors.contains(selectedColorValue) 
                                            ? selectedColorValue 
                                            : (colors.isNotEmpty ? colors.first : null),
                                        decoration: InputDecoration(
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.red),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.red),
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
                                          hintText: 'Select Color',
                                        ),
                                        items: colors.map((color) {
                                          return DropdownMenuItem(
                                            value: color,
                                            child: Text(color),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          if (value != null) {
                                            selectedColor.value = value;
                                          }
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please select a color';
                                          }
                                          return null;
                                        },
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 20),

                                  // Image Selection
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white,
                                    ),
                                    onPressed: pickImages,
                                    child: const Text('Update product images'),
                                  ),
                                  const SizedBox(height: 10),

                                  // Image Preview
                                  ValueListenableBuilder<List<File>>(
                                    valueListenable: selectedImages,
                                    builder: (context, images, _) {
                                      return images.isEmpty
                                          ? const Text('No images selected')
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
                                                          decoration: const BoxDecoration(
                                                            color: Colors.red,
                                                            shape: BoxShape.circle,
                                                          ),
                                                          padding: const EdgeInsets.all(5),
                                                          child: const Icon(
                                                            Icons.close,
                                                            size: 16,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }),
                                            );
                                    },
                                  ),
                                  const SizedBox(height: 20),

                                  // Update Button
                                  ElevatedButton(
                                    onPressed: _updateProduct,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF1F2F33),
                                      minimumSize: const Size(350, 40),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    child: const Text(
                                      'Update Product',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}