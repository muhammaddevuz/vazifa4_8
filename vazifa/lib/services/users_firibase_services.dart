import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dars_8/models/order.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UsersFiribaseServices {
  final userCollection = FirebaseFirestore.instance.collection('users2');

  Future<List<Orders>> getOrders() async {
    List box = [];
    List<Orders> box2 = [];
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userDoc =
          FirebaseFirestore.instance.collection('users2').doc(user.uid);
      final docSnapshot = await userDoc.get();

      if (docSnapshot.exists) {
        final currentUserData = docSnapshot.data() as Map<String, dynamic>;
        box = currentUserData['orders'] ?? [];
      }
    }
    for (var element in box) {
      box2.add(Orders.fromJson(element));
    }
    return box2;
  }

  void addUser(String id, String email) {
    userCollection.doc(id).set({
      "email": email,
    });
  }
}
