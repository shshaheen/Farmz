import 'package:farmz/Views/Screens/consumer/widget/product_item_widget.dart';
import 'package:farmz/controllers/product_controller.dart';
import 'package:farmz/models/product.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final ProductController _productController = ProductController();

  List<Product> products = [];
  String selectedCategory = 'All';

  final List<Map<String, dynamic>> categories = [
    {'label': 'All', 'icon': Icons.all_inclusive},
    {'label': 'Organic', 'icon': Icons.eco},
    {'label': 'Community', 'icon': Icons.groups},
    {'label': 'Local', 'icon': Icons.location_on},
    {'label': 'Pesticide Free', 'icon': Icons.verified_user},
  ];

  @override
  void initState() {
    super.initState();
    fetchProducts(); // Load all initially
  }

  void fetchProducts() async {
    List<Product> fetchedProducts = [];

    if (selectedCategory == 'All') {
      fetchedProducts = await _productController.loadProducts();
    } else {
      fetchedProducts =
          await _productController.loadProductByCategory(selectedCategory);
    }

    setState(() {
      products = fetchedProducts;
    });
  }

  void onCategoryTap(String label) {
    setState(() {
      selectedCategory = label;
    });
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Category filter bar
        SizedBox(
          height: 50,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final category = categories[index];
              final label = category['label'];
              final isSelected = selectedCategory == label;

              return GestureDetector(
                onTap: () => onCategoryTap(label),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFFF0B428)
                        : const Color(0xFFFEF9F1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        category['icon'],
                        size: 18,
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFFF0B428),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        label,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFFF0B428),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 12),

        // Products display
        Expanded(
          child: products.isEmpty
              ? const Center(child: Text("No products available"))
              : Padding(
                padding: const EdgeInsets.all(12.0),
                child: GridView.builder(
                  shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(), // Disable GridView scroll
                    itemCount: products.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 3 / 4,
                    ),
                    itemBuilder: (context, index) {
                      return ProductItemWidget(product: products[index]);
                    },
                  ),
              ),
        ),
      ],
    );
  }
}
