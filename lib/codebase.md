# firebase_options.dart

```dart
// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// \`\`\`dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// \`\`\`
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyACno-l0pyuAmuxMynP4v3NFZem7euk98w',
    appId: '1:573210495277:web:42cb809329375b7b02aba4',
    messagingSenderId: '573210495277',
    projectId: 'appp-609fe',
    authDomain: 'appp-609fe.firebaseapp.com',
    storageBucket: 'appp-609fe.firebasestorage.app',
    measurementId: 'G-XS0X1RD5EW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDRX2ZzAFjdocLbhYkdYKkYJuJYImqdwGQ',
    appId: '1:573210495277:android:25a5f72cdd53bb9f02aba4',
    messagingSenderId: '573210495277',
    projectId: 'appp-609fe',
    storageBucket: 'appp-609fe.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDmjj8Qs1HDH9SXMHe-0gz0d4A8GP3CfAQ',
    appId: '1:573210495277:ios:815aa7c2d170149102aba4',
    messagingSenderId: '573210495277',
    projectId: 'appp-609fe',
    storageBucket: 'appp-609fe.firebasestorage.app',
    iosBundleId: 'com.example.mobileApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDmjj8Qs1HDH9SXMHe-0gz0d4A8GP3CfAQ',
    appId: '1:573210495277:ios:815aa7c2d170149102aba4',
    messagingSenderId: '573210495277',
    projectId: 'appp-609fe',
    storageBucket: 'appp-609fe.firebasestorage.app',
    iosBundleId: 'com.example.mobileApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyACno-l0pyuAmuxMynP4v3NFZem7euk98w',
    appId: '1:573210495277:web:9f46e6d0051ec75302aba4',
    messagingSenderId: '573210495277',
    projectId: 'appp-609fe',
    authDomain: 'appp-609fe.firebaseapp.com',
    storageBucket: 'appp-609fe.firebasestorage.app',
    measurementId: 'G-PZHH5GX2XK',
  );

}
```

# main.dart

```dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_app/pages/login_page.dart';
import 'package:mobile_app/pages/main_page.dart';
import 'package:mobile_app/pages/map_page.dart';
import 'package:mobile_app/pages/camera_page.dart'; // Import CameraTabPage here
import 'package:mobile_app/pages/chatbot_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sports Shop',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return snapshot.hasData ? const HomeScreen() : const LoginPage();
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const MainPage(),
    const MapPage(),
    const CameraTabPage(), // Correct reference for CameraTabPage
    const ChatbotPage(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: 'Camera'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chatbot'),
        ],
      ),
    );
  }
}

```

# pages\camera_page.dart

```dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart'; // For checking platform
import 'dart:typed_data';
import 'dart:convert';  // For Base64 encoding (web)
import 'dart:html' as html;  // For web file reading
import 'dart:io' as io;  // For mobile file handling (make sure to import io for mobile platforms)

class CameraTabPage extends StatefulWidget {
  const CameraTabPage({super.key});

  @override
  _CameraTabPageState createState() => _CameraTabPageState();
}

class _CameraTabPageState extends State<CameraTabPage> {
  dynamic _imageFile; // Use dynamic type to handle both Web and Mobile
  final picker = ImagePicker();
  bool _isProcessing = false;
  String _message = '';
  String? _base64Image; // To store the Base64 image for web compatibility

  @override
  void initState() {
    super.initState();
  }

  // Pick an image from the gallery
  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        if (kIsWeb) {
          _imageFile = pickedFile; // For web, store as XFile
        } else {
          _imageFile = io.File(pickedFile.path); // For mobile, store as io.File
        }
      });

      // Convert image to Base64 for web compatibility
      if (kIsWeb) {
        _convertFileToBase64(pickedFile); // Convert to Base64 on web
      }

      // Directly assign message for hardcoded response
      setState(() {
        _isProcessing = true;
        if (pickedFile.name.toLowerCase().contains("football")) {
          _message = 'This is a football.';
        } else if (pickedFile.name.toLowerCase().contains("basketball")) {
          _message = 'This is a basketball.';
        } else {
          _message = 'This is an unknown object.';
        }
        _isProcessing = false;
      });
    }
  }

  // For Web: Convert the file to Base64
  Future<void> _convertFileToBase64(XFile file) async {
    final reader = html.FileReader();

    // Convert XFile to Blob
    final blob = html.Blob([await file.readAsBytes()]);  // Convert the XFile into a Blob for web compatibility
    reader.readAsDataUrl(blob);  // Reads the Blob and encodes it to Base64 string

    reader.onLoadEnd.listen((e) {
      setState(() {
        _base64Image = reader.result as String;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Upload and Object Recognition')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_imageFile != null)
              Column(
                children: [
                  // Use Image.memory for web compatibility (Base64 encoded image)
                  kIsWeb
                      ? Image.network(
                          _base64Image!,
                          height: 250,
                          width: double.infinity,
                          fit: BoxFit.contain, // To ensure the image fits within the bounds
                        )
                      : Image.file(
                          _imageFile as io.File,
                          height: 250,
                          width: double.infinity,
                          fit: BoxFit.contain, // To ensure the image fits within the bounds
                        ),
                  const SizedBox(height: 20),
                ],
              ),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Upload Image'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {}, // Empty onPressed function (does nothing)
              child: const Text('Camera Button'),
            ),
            if (_isProcessing)
              const CircularProgressIndicator(),
            const SizedBox(height: 20),
            if (_message.isNotEmpty)
              Text(
                _message,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}

```

# pages\cart_item.dart

```dart
class CartItem {
  final String name;
  final String image;
  final double price;
  int quantity;

  CartItem({
    required this.name,
    required this.image,
    required this.price,
    this.quantity = 1,
  });
}

```

# pages\cart_page.dart

```dart
import 'package:flutter/material.dart';

class CartItem {
  final String name;
  final String image;
  final double price;
  int quantity;

  CartItem({required this.name, required this.image, required this.price, this.quantity = 1});
}

class CartPage extends StatelessWidget {
  final List<CartItem> cartItems;

  const CartPage({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Shopping Cart")),
      body: Stack(
        children: [
          // The list of cart items
          ListView.builder(
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
          
          // Pay Button on the bottom right
          Positioned(
            bottom: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("You have successfully paid!!!"),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Text('Pay'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: Colors.green, // Button color
              ),
            ),
          ),
        ],
      ),
    );
  }
}

```

# pages\chatbot_page.dart

```dart
import 'package:flutter/material.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];

  // Hardcoded responses for "Hello" and "What is sport?"
  String _getBotResponse(String userMessage) {
    if (userMessage.toLowerCase() == "hello") {
      return "Hi there! How can I assist you today?";
    } else if (userMessage.toLowerCase() == "what is sport") {
      return "Sport is an activity that involves physical exertion and skill in which an individual or team competes against others. It enhances physical fitness, teamwork, mental strength, discipline, and provides entertainment.";
    } else {
      return "I'm not sure about that.";
    }
  }

  void _sendMessage() {
    final userMessage = _controller.text;
    if (userMessage.isEmpty) return;

    setState(() {
      _messages.add("You: $userMessage");
      _messages.add("Bot: ${_getBotResponse(userMessage)}");
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chatbot')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_messages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(hintText: "Type a message..."),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

```

# pages\login_page.dart

```dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key}); // ✅ Add const

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Welcome, ${userCredential.user!.email}!')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainPage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.message ?? 'Invalid login credentials';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(_errorMessage, style: TextStyle(color: Colors.red)),
                ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Login'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterPage()),
                  );
                },
                child: const Text('Don\'t have an account? Register here'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

# pages\main_page.dart

```dart
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
```

# pages\map_page.dart

```dart
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

```

# pages\product_card.dart

```dart
import 'package:flutter/material.dart';
import 'cart_item.dart';

class ProductCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final double price;
  final Function(CartItem) addToCart;

  const ProductCard({
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    required this.addToCart,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          Image.asset(image, height: 200, width: double.infinity, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(description, style: const TextStyle(fontSize: 14)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('\$$price', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          ElevatedButton(
            onPressed: () {
              addToCart(CartItem(name: title, image: image, price: price));
            },
            child: const Text("Add to Cart"),
          ),
        ],
      ),
    );
  }
}

```

# pages\profile_page.dart

```dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 100, color: Colors.grey),
            const SizedBox(height: 20),
            Text(
              user != null ? "Hello, ${user.email}" : "Not Logged In",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushReplacementNamed('/');
              },
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}

```

# pages\register_page.dart

```dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String _errorMessage = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _errorMessage = 'Passwords do not match!';
      });
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration successful! Welcome, ${userCredential.user!.email}')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(), // ✅ Removed 'const' from here
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.message ?? 'An error occurred during registration';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(_errorMessage, style: TextStyle(color: Colors.red)),
                ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _register();
                  }
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

```

# pages\setting_page.dart

```dart

```

