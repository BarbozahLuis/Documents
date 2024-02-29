import 'package:flutter/material.dart';
import 'package:lista_compra/ComprasController.dart';
import 'package:lista_compra/ComprasView.dart';
import 'package:provider/provider.dart';

class ComprasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      //definindo a tela inicial como a ComprasScreen
      home: ChangeNotifierProvider(create: (context) => ComprasController(),
      child: ComprasScreen(),
      ),
    );
  }
  
}