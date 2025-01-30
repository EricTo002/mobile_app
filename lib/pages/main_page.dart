import 'package:flutter/material.dart';
import 'cart_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<CartItem> _cartItems = [];

  void _addToCart(CartItem item) {
    setState(() {
      final index = _cartItems.indexWhere((i) => i.name == item.name);
      if (index != -1) {
        _cartItems[index].quantity++;
      } else {
        _cartItems.add(item);
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${item.name} added to cart!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sports Shop'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartPage(cartItems: _cartItems),
              ),
            ),
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        children: [
          _buildProductCard(
            'Football',
            'assets/football.jpg',
            60.0,
            'High-quality football for games and practice',
          ),
          _buildProductCard(
            'Baseball',
            'assets/baseball.jpg',
            20.0,
            'Durable baseball for all players',
          ),
          _buildProductCard(
            'Basketball',
            'assets/basketball.jpg',
            90.0,
            'Premium basketball with excellent grip',
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(String name, String image, double price, String desc) {
    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.asset(image, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
                Text(desc, style: const TextStyle(fontSize: 14)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('\$$price', style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    )),
                    ElevatedButton(
                      onPressed: () => _addToCart(CartItem(
                        name: name,
                        image: image,
                        price: price,
                      )),
                      child: const Text('Add to Cart'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}