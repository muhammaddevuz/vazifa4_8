import 'package:dars_8/controllers/products_controller.dart';
import 'package:dars_8/models/product.dart';
import 'package:dars_8/views/widgets/add_product.dart';
import 'package:dars_8/views/widgets/admin_item.dart';
import 'package:dars_8/views/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Provider.of<ProductsController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Admin Panel",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      drawer: const CustomDrawer(),
      body: StreamBuilder(
          stream: productController.list,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final products = snapshot.data!.docs;
            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: products.length,
              itemBuilder: (context, index) {
                Product product = Product.fromJson(products[index]);
                return AdminItem(product: product);
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (ctx) {
              return const AddProduct();
            },
          );
        },
      ),
    );
  }
}
