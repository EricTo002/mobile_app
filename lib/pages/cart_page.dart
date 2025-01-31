import 'package:flutter/material.dart';
import 'cart_item.dart'; // Import CartItem from cart_item.dart

class CartPage extends StatelessWidget {
  final List<CartItem> cartItems;

  const CartPage({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Shopping Cart")),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];
          return ListTile(
            leading: Image.asset(item.image, width: 50),
            title: Text(item.name),
            subtitle: Text("\$${item.price} x ${item.quantity}"),
            trailing: Text("\$${item.price * item.quantity}"),
          );
        },
      ),
    );
  }
}
