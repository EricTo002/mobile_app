import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController _mapController;

  final CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(37.7749, -122.4194), // Default location (San Francisco)
    zoom: 12,
  );

  // ✅ Use _mapController to move the camera
  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  // ✅ Function to move camera to a different location (e.g., New York)
  void _goToNewYork() {
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        const CameraPosition(target: LatLng(40.7128, -74.0060), zoom: 14),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Map'),
        actions: [
          IconButton(
            icon: const Icon(Icons.location_pin),
            onPressed: _goToNewYork, // ✅ Moves the map to New York when clicked
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: _initialPosition,
        onMapCreated: _onMapCreated,
        myLocationEnabled: true,
        zoomControlsEnabled: true,
      ),
    );
  }
}
