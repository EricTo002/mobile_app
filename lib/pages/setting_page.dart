import 'package:flutter/material.dart';

class SettingTabPage extends StatelessWidget {
  const SettingTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.settings, size: 100, color: Colors.red),
          Text('Settings Page', style: TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}
