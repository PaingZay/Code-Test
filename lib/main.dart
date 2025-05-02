//
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:interview_test/dependency_container.dart';
import 'package:interview_test/features/auth/presentation/views/login_screen.dart';
import 'package:interview_test/features/home/presentation/views/home_screen.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  late Future<bool> _loginStatusFuture;

  @override
  void initState() {
    super.initState();
    _loginStatusFuture = _checkLoginStatus();
  }

  Future<bool> _checkLoginStatus() async {
    try {
      String? token = await _storage.read(key: 'access_token');
      return token != null && token.isNotEmpty;
    } catch (e) {
      if (kDebugMode) {
        print("Error reading token: $e");
      }
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: EasyLoading.init(),
      title: 'Interview Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: FutureBuilder<bool>(
        future: _loginStatusFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return const Scaffold(
              body: Center(child: Text('An error occurred')),
            );
          } else if (!snapshot.hasData || !snapshot.data!) {
            return const LoginScreen();
          } else {
            return const HomeScreen();
          }
        },
      ),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      },
    );
  }
}
