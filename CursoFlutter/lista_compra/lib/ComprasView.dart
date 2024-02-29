import 'package:flutter/material.dart';
import 'package:lista_compra/ComprasController.dart';
import 'package:provider/provider.dart';

class ComprasScreen extends StatelessWidget {
  // Controlador para o campo de texto de nova tarefa
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Barra superior do aplicativo
      appBar: AppBar(
        title: Text('Lista de Compras'),
      ),
      //corpo principal do aplicativo
      body: Column(
        children: [
          //campo de texto para adicionar nova compra
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Nova Compra',
                //icone para adicionar tarefa ao pressionar o botao
                suffixIcon: IconButton(
                  onPressed: () {
                    // chamando o método adicionarCompra do Providar para atuzalizar
                    Provider.of<ComprasController>(context, listen: false)
                        .adicionarCompra(_controller.text);
                    //limpar o campo após adicionar compra
                    _controller.clear();
                  },
                  icon: Icon(Icons.add),
                ),
              ),
            ), 
          ),
          //lista de compras usando o consumer do provider para atualização automatica
          Expanded(
            child: Consumer<ComprasController>(
              builder: (context, model, child) {
                return ListView.builder(
                  itemCount: model.compras.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      //exibição do texto da tarefa
                      title: Text(model.compras[index].descricao),
                      //checkbox para marcar a tarefa como concluida
                      trailing: Checkbox(
                        value: model.compras[index].concluida,
                        onChanged: (value) {
                          //chamando o metodo marcarComoConcluida do Provider para atualizar o estado
                          model.marcarComoConcluida(index);
                        },
                      ),
                      //exclui a tarefa ao manter pressionado
                      onLongPress: () {
                        //chamando o método excluirCompra do Provider para atualizar o estado
                        try{
                          model.excluirCompra(index);
                        }catch (e){
                          //exibe a mensagem de erro em um snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString()),),
                          );
                        }
                        
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
