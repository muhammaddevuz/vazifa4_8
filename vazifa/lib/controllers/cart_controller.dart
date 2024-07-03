import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dars_8/models/cart.dart';
import 'package:dars_8/models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartController extends ChangeNotifier {
  final List<Cart> _productsinCart = [];
  final List<Cart> _orderProduct = [];

  List<Cart> get list => [..._productsinCart];
  List<Cart> get order => [..._orderProduct];

  void addtoCard(Product product) {
    bool check = false;
    for (var i = 0; i < _productsinCart.length; i++) {
      if (product.id == _productsinCart[i].id) {
        _productsinCart[i].count++;
        check = true;
      }
    }
    if (!check) {
      _productsinCart.add(Cart(
          id: product.id,
          count: 1,
          imageUrl: product.imageUrl,
          price: product.price,
          title: product.title));
    }

    notifyListeners();
  }

  void incrementProductCount(String id) {
    for (var i = 0; i < _productsinCart.length; i++) {
      if (_productsinCart[i].id == id) {
        _productsinCart[i].count++;
        break;
      }
    }

    notifyListeners();
  }

  Future<void> pay() async {
    List<Map> box = [];

    for (var element in _productsinCart) {
        box.add({
          "imageUrl": element.imageUrl,
          "title": element.title,
          "count": element.count,
          "price": element.price,
        });
      }

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userDoc =
          FirebaseFirestore.instance.collection('users2').doc(user.uid);
      final docSnapshot = await userDoc.get();

      if (docSnapshot.exists) {
        final currentUserData = docSnapshot.data() as Map<String, dynamic>;
        final List previousCorrectAnswer = currentUserData['orders'] ?? [];
         previousCorrectAnswer.addAll(box);

        await userDoc.update({'orders': previousCorrectAnswer});
      }
    }
    _productsinCart.clear();

    notifyListeners();
  }

  void decrementProductCount(String id) {
    for (var i = 0; i < _productsinCart.length; i++) {
      if (_productsinCart[i].id == id) {
        if (_productsinCart[i].count == 1) {
          _productsinCart.removeAt(i);
        } else {
          _productsinCart[i].count--;
        }
      }
    }
    notifyListeners();
  }

  double totalPrice() {
    double total = 0;
    for (var product in _productsinCart) {
      total += product.count * product.price;
    }

    return total;
  }

  int totalCount() {
    int count = 0;
    for (var product in _productsinCart) {
      count += product.count;
    }

    return count;
  }
}
