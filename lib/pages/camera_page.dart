import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart'; // Import camera package
import 'package:google_ml_kit/google_ml_kit.dart'; // Import Google ML Kit for object detection

class CameraTabPage extends StatefulWidget {
  const CameraTabPage({super.key});

  @override
  _CameraTabPageState createState() => _CameraTabPageState();
}

class _CameraTabPageState extends State<CameraTabPage> {
  late CameraController _controller;
  late List<CameraDescription> cameras;
  late CameraDescription _camera;
  bool _isProcessing = false;
  String _detectedObject = 'No object detected';

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    // Get the list of available cameras
    cameras = await availableCameras();
    _camera = cameras.first;

    // Initialize the camera controller
    _controller = CameraController(
      _camera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    // Initialize the controller
    await _controller.initialize();

    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Capture image and detect objects
  Future<void> _captureAndDetect() async {
    if (_controller.value.isTakingPicture || _isProcessing) return;

    setState(() {
      _isProcessing = true;
    });

    // Capture the image
    final image = await _controller.takePicture();

    // Load the image and process it
    final inputImage = InputImage.fromFilePath(image.path);
    final objectDetector = GoogleMlKit.vision.objectDetector();
    final objects = await objectDetector.processImage(inputImage);

    // Get the object labels
    String detected = 'Objects detected:\n';
    for (var object in objects) {
      detected += '${object.labels.join(', ')}\n';
    }

    setState(() {
      _detectedObject = detected.isEmpty ? 'No object detected' : detected;
      _isProcessing = false;
    });

    // Dispose the object detector
    objectDetector.close();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera and Object Detection'),
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: _captureAndDetect,
          ),
        ],
      ),
      body: Column(
        children: [
          // Display the camera preview
          SizedBox(
            height: 400,
            width: double.infinity,
            child: CameraPreview(_controller),
          ),
          const SizedBox(height: 16),
          // Display the detected object result
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _detectedObject,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
