import 'package:flutter/material.dart';

class MainTabPage extends StatelessWidget {
  const MainTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.home, size: 100, color: Colors.blue),
          Text('Main Page', style: TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}
