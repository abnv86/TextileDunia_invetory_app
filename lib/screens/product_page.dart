import 'dart:io';
import 'package:app/modal/product_modal.dart';
import 'package:app/screens/notification.dart';
import 'package:app/screens/product_detail_page.dart';
import 'package:app/utilities/drawer.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Box<ProductModal> productBox;
  
  // Search and filter states
  String searchQuery = '';
  String selectedCategory = '';
  String selectedBrand = '';
  String selectedColor = '';
  String selectedSort = '';
  bool showSortMenu = false;

  // Get unique values for filters
  List<String> getUniqueCategories(List<ProductModal> products) {
    return products.map((p) => p.productCategory).toSet().toList()..sort();
  }

  List<String> getUniqueBrands(List<ProductModal> products) {
    return products.map((p) => p.productBrandName).toSet().toList()..sort();
  }

  List<String> getUniqueColors(List<ProductModal> products) {
    return products.map((p) => p.productColor).toSet().toList()..sort();
  }

  // Filter products based on search and filters
  List<ProductModal> filterProducts(List<ProductModal> products) {
    return products.where((product) {
      final matchesSearch = searchQuery.isEmpty ||
          product.itemName.toLowerCase().contains(searchQuery.toLowerCase()) ||
          product.productBrandName.toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesCategory = selectedCategory.isEmpty || 
          product.productCategory == selectedCategory;
      
      final matchesBrand = selectedBrand.isEmpty || 
          product.productBrandName == selectedBrand;
      
      final matchesColor = selectedColor.isEmpty || 
          product.productColor == selectedColor;

      return matchesSearch && matchesCategory && matchesBrand && matchesColor;
    }).toList();
  }

  // Sort products
  void sortProducts(List<ProductModal> products) {
    switch (selectedSort) {
      case 'price_asc':
        products.sort((a, b) => a.productSalesRate.compareTo(b.productSalesRate));
        break;
      case 'price_desc':
        products.sort((a, b) => b.productSalesRate.compareTo(a.productSalesRate));
        break;
      case 'name_asc':
        products.sort((a, b) => a.itemName.compareTo(b.itemName));
        break;
      case 'name_desc':
        products.sort((a, b) => b.itemName.compareTo(a.itemName));
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    productBox = Hive.box<ProductModal>('productBox');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF5F6F9),
      body: ValueListenableBuilder(
        valueListenable: productBox.listenable(),
        builder: (context, Box<ProductModal> box, _) {
          var products = box.values.toList();
          final filteredProducts = filterProducts(products);
          sortProducts(filteredProducts);
          final keys = box.keys.toList();

          final categories = getUniqueCategories(products);
          final brands = getUniqueBrands(products);
          final colors = getUniqueColors(products);

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                expandedHeight: 280, // Increased height for filters
                leading: IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.menu_rounded,
                        color: Color(0xFF1F2F33), size: 20),
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const NotificationScreen(),
                      ));
                    },
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.notifications_active_outlined,
                          color: Color(0xFF1F2F33)),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      Container(
                        height: 220,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromARGB(255, 40, 136, 160),
                              Color(0xFF2C3E50)
                            ],
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                      ),
                      // Search Bar
                      Positioned(
                        top: 190,
                        left: 20,
                        right: 20,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.grey.shade300),
                                    ),
                                    child: TextField(
                                      onChanged: (value) {
                                        setState(() {
                                          searchQuery = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        prefixIcon: const Icon(Icons.search,
                                            size: 20, color: Color(0xFF1F2F33)),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide.none,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide:
                                              BorderSide(color: Colors.blue.shade300),
                                        ),
                                        hintText: 'Search products',
                                        hintStyle: const TextStyle(
                                            color: Colors.grey, fontSize: 15),
                                        contentPadding:
                                            const EdgeInsets.symmetric(vertical: 9),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showSortMenu = !showSortMenu;
                                    });
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF3498DB),
                                          Color(0xFF2980B9)
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: const Icon(Icons.filter_list,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            // Filter Row
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  // Category Filter
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.grey.shade300),
                                    ),
                                    child: DropdownButton<String>(
                                      value: selectedCategory.isEmpty ? null : selectedCategory,
                                      hint: const Text('Category'),
                                      underline: const SizedBox(),
                                      items: [
                                        const DropdownMenuItem(
                                          value: '',
                                          child: Text('All Categories'),
                                        ),
                                        ...categories.map((category) => DropdownMenuItem(
                                          value: category,
                                          child: Text(category),
                                        )),
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          selectedCategory = value ?? '';
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  // Brand Filter
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.grey.shade300),
                                    ),
                                    child: DropdownButton<String>(
                                      value: selectedBrand.isEmpty ? null : selectedBrand,
                                      hint: const Text('Brand'),
                                      underline: const SizedBox(),
                                      items: [
                                        const DropdownMenuItem(
                                          value: '',
                                          child: Text('All Brands'),
                                        ),
                                        ...brands.map((brand) => DropdownMenuItem(
                                          value: brand,
                                          child: Text(brand),
                                        )),
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          selectedBrand = value ?? '';
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  // Color Filter
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.grey.shade300),
                                    ),
                                    child: DropdownButton<String>(
                                      value: selectedColor.isEmpty ? null : selectedColor,
                                      hint: const Text('Color'),
                                      underline: const SizedBox(),
                                      items: [
                                        const DropdownMenuItem(
                                          value: '',
                                          child: Text('All Colors'),
                                        ),
                                        ...colors.map((color) => DropdownMenuItem(
                                          value: color,
                                          child: Text(color),
                                        )),
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          selectedColor = value ?? '';
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Sort Menu
                      if (showSortMenu)
                        Positioned(
                          top: 190,
                          right: 20,
                          child: Container(
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                ListTile(
                                  title: const Text('Price: Low to High'),
                                  onTap: () {
                                    setState(() {
                                      selectedSort = 'price_asc';
                                      showSortMenu = false;
                                    });
                                  },
                                ),
                                ListTile(
                                  title: const Text('Price: High to Low'),
                                  onTap: () {
                                    setState(() {
                                      selectedSort = 'price_desc';
                                      showSortMenu = false;
                                    });
                                  },
                                ),
                                ListTile(
                                  title: const Text('Name: A to Z'),
                                  onTap: () {
                                    setState(() {
                                      selectedSort = 'name_asc';
                                      showSortMenu = false;
                                    });
                                  },
                                ),
                                ListTile(
                                  title: const Text('Name: Z to A'),
                                  onTap: () {
                                    setState(() {
                                      selectedSort = 'name_desc';
                                      showSortMenu = false;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // Product Grid
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.75,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final product = filteredProducts[index];
                      final productKey = keys[products.indexOf(product)];

                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              spreadRadius: 0,
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetailPage(
                                        product: product,
                                        productKey: productKey as int,
                                      ),
                                    ),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                  child: product.productImages.isNotEmpty
                                      ? Image.file(
                                          File(product.productImages[0]),
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Container(
                                              color: Colors.grey[300],
                                              child: const Center(
                                                child: Icon(
                                                  Icons.broken_image,
                                                  color: Colors.grey,
                                                  size: 40,
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      : Container(
                                          color: Colors.grey[300],
                                          child: const Center(
                                            child: Icon(
                                              Icons.image,
                                              color: Colors.grey,
                                              size: 40,
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.productCategory,
                                      style: TextStyle(
                                        color: Colors.blue.shade700,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      product.productBrandName,
                                      style: const TextStyle(
                                        color: Color(0xFF1F2F33),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '₹${product.productSalesRate}',
                                      style: const TextStyle(
                                        color: Color(0xFF2ECC71),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    childCount: filteredProducts.length,
                  ),
                ),
              ),
            ],
          );
        },
      ),
      drawer: const CustomDrawer(),
    );
  }
} 