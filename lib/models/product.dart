// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Product {
  final String id;
  final String productName;
  final int productPrice;
  final String location;
  final String description;
  final String speciality;
  final String farmerId;
  final String image;

  Product({required this.id, required this.productName, required this.productPrice, required this.location, required this.description, required this.speciality, required this.farmerId, required this.image});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productName': productName,
      'productPrice': productPrice,
      'location': location,
      'description': description,
      'speciality': speciality,
      'farmerId': farmerId,
      'image': image,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['_id'] ?? '',
      productName: map['productName'] ?? '',
      productPrice: map['productPrice'] ?? 0,
      location: map['location'] ?? '',
      description: map['description'] ?? '',
      speciality: map['speciality'] ?? '',
      farmerId: map['farmerId'] ?? '',
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
