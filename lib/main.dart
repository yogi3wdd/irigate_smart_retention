import 'package:flutter/material.dart';
import '../screen/login.dart';
import '../screen/home.dart';
import '../screen/statistik.dart';
import '../screen/setting.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      routes: {
        '/login': (context) => const Login(),
        '/home': (context) => const Home(),
        '/statistik': (context) => const Statistik(),
        '/setting': (context) => const Setting(),
      },

      initialRoute: '/login',
    );
  }
}
