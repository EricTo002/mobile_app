import 'package:flutter/material.dart';
import 'cart_item.dart';

class ProductCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final double price;
  final Function(CartItem) addToCart;

  const ProductCard({
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    required this.addToCart,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          Image.asset(image, height: 200, width: double.infinity, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(description, style: const TextStyle(fontSize: 14)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('\$$price', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          ElevatedButton(
            onPressed: () {
              addToCart(CartItem(name: title, image: image, price: price));
            },
            child: const Text("Add to Cart"),
          ),
        ],
      ),
    );
  }
}
