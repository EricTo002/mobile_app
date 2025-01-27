import 'package:flutter/material.dart';

class CameraTabPage extends StatelessWidget {
  const CameraTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.camera_alt, size: 100, color: Colors.orange),
          Text('Camera Page', style: TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}
