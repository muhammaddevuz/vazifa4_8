import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String id;
  String title;
  double price;
  String imageUrl;
  String category;
  bool isLiked;
  Product({
    required this.category,
    required this.id,
    required this.imageUrl,
    required this.price,
    required this.title,
    required this.isLiked,
  });


  factory Product.fromJson(QueryDocumentSnapshot query) {
    return Product(
      id: query.id,
      category: query['category'],
      imageUrl: query['imageUrl'],
      title: query['title'],
      isLiked: query['isLiked'],
      price: query['price'],
    );
  }
}
