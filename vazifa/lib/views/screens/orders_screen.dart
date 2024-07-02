import 'package:dars_8/controllers/user_controller.dart';
import 'package:dars_8/models/order.dart';
import 'package:dars_8/views/widgets/custom_drawer.dart';
import 'package:dars_8/views/widgets/order_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userController = context.watch<UserController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Orders",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      drawer: const CustomDrawer(),
      body: FutureBuilder(
        future: userController.getOrders(),
        builder: (context, AsyncSnapshot<List<Orders>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Orderlar mavjud emas"));
          }

          final List<Orders> orders = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              Orders order = orders[index];
              return OrderProduct(order: order);
            },
          );
        },
      ),
    );
  }
}
