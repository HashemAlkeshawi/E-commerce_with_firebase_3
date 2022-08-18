import 'package:flutter/material.dart';

class Product {
  String? id;
  late String title;
  late String imageUrl;
  late String price;
  bool? isFavourite, isPopular;

  Product({
    this.id,
    required this.imageUrl,
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.price,
  });

  Product.fromMap(Map<String, dynamic> map) {
    price = map['price'];
    title = map['title'];
    imageUrl = map['imageUrl'];
  }

  toMap() {
    return {
      'title': title,
      'imageUrl': imageUrl,
      'price': price,
      'id': id,
      'isFavourite': isFavourite,
      'ispopular': isPopular,
    };
  }
}
