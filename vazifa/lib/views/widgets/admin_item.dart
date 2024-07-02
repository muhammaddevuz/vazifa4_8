import 'package:dars_8/controllers/products_controller.dart';
import 'package:dars_8/models/product.dart';
import 'package:dars_8/views/widgets/edit_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AdminItem extends StatelessWidget {
  Product product;
  AdminItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final productController = Provider.of<ProductsController>(context);
    return Column(
      children: [
        ListTile(
          leading: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            clipBehavior: Clip.hardEdge,
            width: 100,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "\$${product.price}",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) {
                      return EditProduct(
                        product: product,
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
              ),
              IconButton(
                onPressed: () {
                  productController.deleteProduct(product.id);
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20)
      ],
    );
  }
}
