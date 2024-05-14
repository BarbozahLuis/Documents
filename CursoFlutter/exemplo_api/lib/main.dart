import 'package:exemplo_api/screen.dart';
import 'package:flutter/material.dart';


void main(List<String> args) {
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exemplo API - Previsão de tempo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: WeatherScreen(),
    );
  }
}