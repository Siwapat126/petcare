import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const PetCareApp());
}

class PetCareApp extends StatelessWidget {
  const PetCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Care',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFAF7F2),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE07A5F),
          primary: const Color(0xFFE07A5F),
        ),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
