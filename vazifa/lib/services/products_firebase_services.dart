import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProductsFirebaseServices {
  final _productsCollection =
      FirebaseFirestore.instance.collection("products2");
  final _productsImageStorage = FirebaseStorage.instance;

  Stream<QuerySnapshot> getProducts() async* {
    yield* _productsCollection.snapshots();
  }

  Future<void> addProduct(String name, File imageFile, double price) async {
    final imageReference = _productsImageStorage
        .ref()
        .child("products")
        .child("images")
        .child("$name.jpg");
    final uploadTask = imageReference.putFile(
      imageFile,
    );

    await uploadTask.whenComplete(() async {
      final imageUrl = await imageReference.getDownloadURL();
      await _productsCollection.add({
        "title": name,
        "imageUrl": imageUrl,
        "price": price,
        "category": "living",
        "isLiked": true,
      });
    });
  }

  Future<void> editProduct(
      String id, String name, File imageFile, double price) async {
    final imageReference = _productsImageStorage
        .ref()
        .child("products")
        .child("images")
        .child("$name.jpg");
    final uploadTask = imageReference.putFile(
      imageFile,
    );

    await uploadTask.whenComplete(() async {
      final imageUrl = await imageReference.getDownloadURL();
      await _productsCollection.doc(id).update({
        "title": name,
        "imageUrl": imageUrl,
        "price": price,
        "category": "living",
        "isLiked": true,
      });
    });
  }

  Future<void> deleteProduct(String id) async {
    _productsCollection.doc(id).delete();
  }
}
