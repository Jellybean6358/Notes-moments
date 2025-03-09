import 'package:flutter/material.dart';
import 'screens/homepage';
import 'screens/favpage';
import 'animated/welcome_animate';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Journal App',
      theme: ThemeData(useMaterial3: true, primarySwatch: Colors.blue),
      home: const WelcomeAnimateScreen(),
    );
  }
}
