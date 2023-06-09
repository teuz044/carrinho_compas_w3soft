import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

import 'model/Item.dart';

void main() => runApp(
  MaterialApp(
    home: Directionality(
      textDirection: TextDirection.ltr,
      child: CarrinhoComprasApp(),
    ),
  ),
);

class CarrinhoComprasApp extends StatefulWidget {
  @override
  _CarrinhoComprasAppState createState() => _CarrinhoComprasAppState();
}

class _CarrinhoComprasAppState extends State<CarrinhoComprasApp> {
  List<Item> _carrinho = [];
  double _total = 0;
  bool _isLoading = false;
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _valorController = TextEditingController();
  TextEditingController _imageUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getAllItens();
  }

  Future<void> _getAllItens() async {
    setState(() {
      _isLoading = true;
    });

    try {
      Response response = await Dio().get('http://localhost:8080/api/itens');
      List<dynamic> data = response.data;

      List<Item> itens = [];
      double total = 0;

      for (dynamic itemData in data) {
        if (itemData['nome'] != null &&
            itemData['valor'] != null &&
            itemData['imageUrl'] != null) {
          Item item = Item(
            nome: itemData['nome'],
            valor: itemData['valor'].toDouble(),
            imageUrl: itemData['imageUrl'],
          );
          itens.add(item);
          total += item.valor;
        }
      }

      setState(() {
        _carrinho = itens;
        _total = total;
        _isLoading = false;
      });
    } catch (e) {
      print('Erro ao obter itens: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _adicionarItem(Item item) async {
    setState(() {
      _carrinho.add(item);
      _total += item.valor;
    });

    try {
      Response response = await Dio().post(
        'http://localhost:8080/api/adicionaritem',
        data: {
          'nome': item.nome,
          'valor': item.valor,
          'imageUrl': item.imageUrl,
        },
      );

      print(response.data);
    } catch (e) {
      print('Erro ao adicionar item: $e');
    }
  }

  Future<void> _removerItem(Item item) async {
    setState(() {
      _carrinho.remove(item);
      _total -= item.valor;
    });

    try {
      Response response = await Dio().delete(
        'http://localhost:8080/api/removeritem',
        data: {
          'nome': item.nome,
          'valor': item.valor,
          'imageUrl': item.imageUrl,
        },
      );

      print(response.data);
    } catch (e) {
      print('Erro ao remover item: $e');
    }

  }

  Future<void> _exibirDialogoAdicionarItem() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Adicionar Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                ),
              ),
              TextField(
                controller: _valorController,
                decoration: InputDecoration(
                  labelText: 'Valor',
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _imageUrlController,
                decoration: InputDecoration(
                  labelText: 'URL da imagem',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                String nome = _nomeController.text.trim();
                String valorText = _valorController.text.trim();
                String imageUrl = _imageUrlController.text.trim();
                double valor = double.tryParse(valorText) ?? 0.0;

                if (nome.isNotEmpty && valor > 0) {
                  Item item = Item(
                    nome: nome,
                    valor: valor,
                    imageUrl: imageUrl,
                  );
                  _adicionarItem(item);
                }

                Navigator.of(context).pop();
              },
              child: Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho de Compras'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: _isLoading
                ? Center(
              child: CircularProgressIndicator(),
            )
                : _carrinho.isNotEmpty
                ? ListView.builder(
              itemCount: _carrinho.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 16.0),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (_) {
                    _removerItem(_carrinho[index]);
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: ListTile(
                      leading: CachedNetworkImage(
                        imageUrl: _carrinho[index].imageUrl,
                        placeholder: (_, __) => SpinKitCircle(
                          color: Colors.grey,
                          size: 24.0,
                        ),
                        errorWidget: (_, __, ___) => Icon(
                          Icons.error,
                          color: Colors.grey,
                        ),
                        height: 48.0,
                        width: 48.0,
                      ),
                      title: Text(_carrinho[index].nome),
                      subtitle: Text(
                        'R\$ ${_carrinho[index].valor.toStringAsFixed(2)}',
                      ),
                    ),
                  ),
                );
              },
            )
                : Center(
              child: Text('Nenhum item no carrinho'),
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Total: R\$ ${_total.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _exibirDialogoAdicionarItem();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
