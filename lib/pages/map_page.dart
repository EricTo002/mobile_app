import 'package:flutter/material.dart';

class MapTabPage extends StatelessWidget {
  const MapTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.map, size: 100, color: Colors.green),
          Text('Map Page', style: TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}
