import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:farmz/global_variables.dart';
import 'package:farmz/models/product.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:farmz/services/manage_http_response.dart';

class ProductController {
  //upload product
  Future<void> uploadProduct({
    required String productName,
    required double productPrice,
    required String location,
    required String speciality,
    required String farmerId,
    required File? pickedImage,
    required context,
  }) async {
    try {
      if (pickedImage != null ) {
        final cloudinary = CloudinaryPublic("dvlvqsufy", "yykjowx6");

       

          CloudinaryResponse cloudinaryResponse = await cloudinary.uploadFile(
            CloudinaryFile.fromFile(pickedImage.path, folder: productName),
          );
          String image = cloudinaryResponse.secureUrl;
         
          final Product product = Product(
            id: '',
            productName: productName,
            productPrice: productPrice,
            location:location,
            speciality: speciality,
            farmerId: farmerId,
            image: image,
          );
          // print(product.toJson());
          http.Response response = await http.post(
            Uri.parse('$uri/api/add-product'),
            body: product.toJson(),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
          );

          manageHttpResponse(
            response: response,
            context: context,
            onSuccess: () {
              showSnackBar(context, 'Product Uploaded');
            },
          );
      } else {
        showSnackBar(context, 'Select Image');
      }
    } catch (e, stacktrace) {
      print('❌ Error in uploadProduct: $e');
      print('📍 Stacktrace: $stacktrace');
      showSnackBar(context, 'Error uploading product. Check logs.');
    }
  }


//Load Products
Future<List<Product>> loadProducts() async {
  try {
    http.Response response = await http.get(
      Uri.parse('$uri/api/get-products'),
      headers: <String, String>{
        'Content-Type': 'application/json; chartset=UTF-8 ',
      },
    );
    if (response.statusCode == 200) {
      //Decode the json response body into a list  of dynamic object
      final List<dynamic> data = json.decode(response.body);
      //map each items in the list to product model object which we can use

      List<Product> products = data
          .map((product) => Product.fromJson(product)).toList();
      return products;
    } else if (response.statusCode == 404) {
      return [];
    } else {
      //if status code is not 200 , throw an execption   indicating failure to load the popular products
      throw Exception('Failed to load popular products');
    }
  } catch (e) {
    throw Exception('Error loading product : $e');
  }
}

//load product by category function
  Future<List<Product>> loadProductByCategory(String speciality) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/products-by-category/$speciality'),
        headers: <String, String>{
          'Content-Type': 'application/json; chartset=UTF-8 ',
        },
      );
      if (response.statusCode == 200) {
        //Decode the json response body into a list  of dynamic object
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;
        //map each items in the list to product model object which we can use

        List<Product> products = data
            .map((product) => Product.fromMap(product as Map<String, dynamic>))
            .toList();
        return products;
      } else if (response.statusCode == 404) {
        return [];
      } else {
        //if status code is not 200 , throw an execption   indicating failure to load the popular products
        throw Exception('Failed to load popular products');
      }
    } catch (e) {
      throw Exception('Error loading product : $e');
    }
  }

  
}
