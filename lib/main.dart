import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import '../screen/login.dart';
import '../screen/home.dart';
import '../screen/statistik.dart';
import '../screen/setting.dart';
import '../screen/splash.dart';
import '../screen/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      routes: {
        '/splash': (context) => const Splash(),
        '/login': (context) => const Login(),
        '/home': (context) => const Home(),
        '/statistik': (context) => const Statistik(),
        '/setting': (context) => const Setting(),
        '/signup': (context) => const Signup(),
      },

      initialRoute: '/splash',
    );
  }
}
