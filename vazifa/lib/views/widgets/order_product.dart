import 'package:dars_8/models/order.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OrderProduct extends StatelessWidget {
  Orders order;
  OrderProduct({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            clipBehavior: Clip.hardEdge,
            width: 100,
            child: Image.network(
              order.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                order.title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Text(
                    "Amoun: ${order.count}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 25,
                    width: 2,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Total: \$${order.count * order.price}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.green,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 20)
      ],
    );
  }
}
