import 'package:flutter/material.dart';
import 'package:wmc_test_1/pages/home.dart';
import 'package:wmc_test_1/pages/location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "World Time",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      initialRoute: '/',
      routes: {
        '/': (context) => const Home(title: "World Time"),
        '/location': (context) => const Location(),
      },
    );
  }
}
