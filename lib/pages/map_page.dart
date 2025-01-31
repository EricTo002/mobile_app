import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(37.7749, -122.4194),
    zoom: 12.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Map")),
      body: const GoogleMap(
        initialCameraPosition: _initialPosition,
      ),
    );
  }
}
