// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:farmz/Views/Screens/consumer/product_detail_screen.dart';
import 'package:farmz/models/product.dart';
import 'package:farmz/providers/cart_provider.dart';
import 'package:farmz/services/manage_http_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductItemWidget extends ConsumerWidget {
  final Product product;
  const ProductItemWidget({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartProviderObject = ref.read(cartProvider.notifier);
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductDetailScreen(product: product);
        }));
      },
      child: Container(
        width: 170,
        margin: EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 170,
              decoration: BoxDecoration(
                color: Color(0xffF2F2F2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      product.image,
                      height: 170,
                      width: 170,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 15,
                    right: 2,
                    child: Image.asset(
                      'assets/icons/love.png',
                      width: 26,
                      height: 26,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        // Add to Cart
                        cartProviderObject.addProductToCart(
                          productName: product.productName,
                          productPrice: product.productPrice,
                          speciality: product.speciality,
                          location: product.location,
                          farmerId: product.farmerId,
                          image: product.image,
                          productId: product.id,
                          quantity: 1,
                        );
                        showSnackBar(context, "Added ${product.productName} to cart");
                      },
                      child: Image.asset(
                        'assets/icons/cart.png',
                        height: 26,
                        width: 26,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              product.productName,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                fontSize: 14,
                color: Color(
                  0xFF212121,
                ),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
          ],
        ),
      ),
    );
  }
}
