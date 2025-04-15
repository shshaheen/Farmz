import 'package:carousel_slider/carousel_slider.dart';
import 'package:farmz/Views/Screens/consumer/widget/product_item_widget.dart';
import 'package:farmz/models/product.dart';
import 'package:flutter/material.dart';
import 'package:farmz/controllers/product_controller.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late Future<List<Product>> futureProducts =
      ProductController().loadProducts();
  final List<String> images = [
    'assets/images/banner2.jpg',
    'assets/images/banner3.jpg',
    'assets/images/banner8.jpg',
    'assets/images/banner6.avif',
  ];

  @override
  void initState() {
    super.initState();
    futureProducts = ProductController().loadProducts();
  }

  @override
  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                viewportFraction: 0.9,
              ),
              items: images.map((url) {
                return Builder(
                  builder: (BuildContext context) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        url,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Text(
              "Products",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          FutureBuilder<List<Product>>(
            future: futureProducts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("No Products..!"));
              } else {
                final products = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(), // Disable GridView scroll
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
                );
              }
            },
          ),
          const SizedBox(height: 80), // Add spacing for bottom navigation bar
        ],
      ),
    ),
  );
}

}
