import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dars_8/services/products_firebase_services.dart';
import 'package:flutter/material.dart';

class ProductsController with ChangeNotifier {
  final _productsFirebaseService = ProductsFirebaseServices();

  Stream<QuerySnapshot> get list async* {
    yield* _productsFirebaseService.getProducts();
  }

  Future<void> addProduct(String name, File imageFile, double price) async {
    await _productsFirebaseService.addProduct(name, imageFile, price);
  }

  Future<void> editProduct(
      String id, String name, File imageFile, double price) async {
    await _productsFirebaseService.editProduct(id, name, imageFile, price);
  }

  Future<void> deleteProduct(String id) async {
    await _productsFirebaseService.deleteProduct(id);
  }
}
