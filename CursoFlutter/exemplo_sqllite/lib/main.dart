import 'package:exemplo_sqllite/View.dart';
import 'package:flutter/material.dart';

void main (){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(//pacote principal onde vai ter todo material para contrução
        title: "Exemplo SqlLite",
        theme: ThemeData(
          primarySwatch: Colors.blue
        ),
        home: HomePage(),
    ); 

  }
}