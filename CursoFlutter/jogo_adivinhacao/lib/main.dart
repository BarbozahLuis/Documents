import 'package:flutter/material.dart';
import 'dart:math';
void main() {
  runApp(AdivinhacaoApp());
}

class AdivinhacaoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Adivinhacao(),
    );
  }
}
//criando a classe
class Adivinhacao extends StatefulWidget {
  @override
  _AdivinhacaoState createState() => _AdivinhacaoState();
}

//criando atributos
class _AdivinhacaoState extends State<Adivinhacao> {
  TextEditingController _controllerTentativa = TextEditingController();
  String _mensagem = '';
  late int _numeroSecreto;
  bool _acertou = false;

  void _iniciarJogo(){
    setState(() {
      _numeroSecreto = Random().nextInt(1000) + 1;
      _mensagem = '';
      _acertou = false;
    });
  }
  void _verificarTentativa(){
    int? tentativa = int.tryParse(_controllerTentativa.text);

    if(tentativa!=null){
      setState(() {
        if(tentativa == _numeroSecreto){
          _mensagem = 'Parabéns você acertou o numero secreto que é $_numeroSecreto!';
          _acertou = true;
        } else if(tentativa < _numeroSecreto){
          _mensagem = 'Tente um numero maior';
        }else{
          _mensagem = 'Tente um numero menor.';
        }
      });
    }
  }
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jogo de Adivinhação Flutter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controllerTentativa,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Tentativa'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _verificarTentativa,
              child: Text('Verificar'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _iniciarJogo,
              child: Text('Iniciar Novo Jogo'),
            ),
            SizedBox(height: 16.0),
            Text(
              _mensagem,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

}


