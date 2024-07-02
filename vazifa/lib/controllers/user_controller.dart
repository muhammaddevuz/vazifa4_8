import 'package:dars_8/models/order.dart';
import 'package:dars_8/services/users_firibase_services.dart';
import 'package:flutter/material.dart';

class UserController extends ChangeNotifier {
  final UsersFiribaseServices quizFirebaseServices = UsersFiribaseServices();

  Future<List<Orders>> getOrders() {
    return quizFirebaseServices.getOrders();
  }

  void addUser(String id, String email, int correctAnswer) {
    quizFirebaseServices.addUser(id, email, correctAnswer);
  }
}
