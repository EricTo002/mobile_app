import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart'; // To open URL

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(22.3193, 114.1694), // Default location set to Hong Kong
    zoom: 12.0,
  );

  // Define markers with descriptions for multiple locations
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _initializeMarkers();
  }

  // Initialize the markers
  void _initializeMarkers() {
    _markers.add(
      Marker(
        markerId: MarkerId('hongkong_park'),
        position: LatLng(22.2819, 114.1584),
        infoWindow: InfoWindow(
          title: 'Hong Kong Park',
          snippet:
              'Hong Kong Park is a lush, green oasis in the heart of the city. It offers beautiful landscapes, fountains, and a peaceful escape from the hustle and bustle.',
          onTap: () => _openLocation('https://en.wikipedia.org/wiki/Hong_Kong_Park'),
        ),
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId('kowloon_tsai'),
        position: LatLng(22.3199, 114.1718),
        infoWindow: InfoWindow(
          title: 'Kowloon Tsai Sports Ground',
          snippet:
              'Kowloon Tsai Sports Ground is a popular venue for various sports. It features open fields for football, cricket, and athletics, offering recreational activities for locals and tourists.',
          onTap: () => _openLocation('https://en.wikipedia.org/wiki/Kowloon_Tsai_Sports_Ground'),
        ),
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId('victoria_park'),
        position: LatLng(22.2813, 114.1890),
        infoWindow: InfoWindow(
          title: 'Victoria Park',
          snippet:
              'Victoria Park, one of Hong Kong’s oldest and largest parks, is a beautiful green space with walking paths, sports courts, and plenty of facilities for public enjoyment.',
          onTap: () => _openLocation('https://en.wikipedia.org/wiki/Victoria_Park,_Hong_Kong'),
        ),
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId('kowloon_walled'),
        position: LatLng(22.3155, 114.1920),
        infoWindow: InfoWindow(
          title: 'Kowloon Walled City Park',
          snippet:
              'Kowloon Walled City Park is a historical site that was once home to the densest place on Earth. Today, it features beautiful landscaping and relics of its past.',
          onTap: () => _openLocation('https://en.wikipedia.org/wiki/Kowloon_Walled_City'),
        ),
      ),
    );
  }

  // Open the location in the browser
  void _openLocation(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not open the location';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Map of Hong Kong Playground Locations")),
      body: GoogleMap(
        initialCameraPosition: _initialPosition,
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {},
      ),
    );
  }
}
