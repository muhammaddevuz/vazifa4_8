import 'dart:io';
import 'package:dars_8/controllers/products_controller.dart';
import 'package:dars_8/models/product.dart';
import 'package:dars_8/utils/messages.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EditProduct extends StatefulWidget {
  Product product;
  EditProduct({super.key, required this.product});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  File? imageFile;

  void addCar() async {
    Messages.showLoadingDialog(context);
    await context.read<ProductsController>().editProduct(widget.product.id, titleController.text, imageFile!, 1500);

    if (context.mounted) {
      titleController.clear();
      priceController.clear();
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

  void openGallery() async {
    final imagePicker = ImagePicker();
    final XFile? pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      requestFullMetadata: false,
    );

    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
    }
  }

  void openCamera() async {
    final imagePicker = ImagePicker();
    final XFile? pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      requestFullMetadata: false,
    );

    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
    }
  }

  @override
  void initState() {
    titleController.text = widget.product.title;
    priceController.text = widget.product.price.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Mashina Qo'shish"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Mahsulot nomi",
            ),
          ),
          TextField(
            controller: priceController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Mahsulot narxi",
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Rasm Qo'shish",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: openCamera,
                label: const Text("Kamera"),
                icon: const Icon(Icons.camera),
              ),
              TextButton.icon(
                onPressed: openGallery,
                label: const Text("Galleriya"),
                icon: const Icon(Icons.image),
              ),
            ],
          ),
          if (imageFile != null)
            SizedBox(
              height: 200,
              child: Image.file(
                imageFile!,
                fit: BoxFit.cover,
              ),
            )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Bekor Qilish"),
        ),
        FilledButton(
          onPressed: addCar,
          child: const Text("Saqlash"),
        ),
      ],
    );
  }
}
