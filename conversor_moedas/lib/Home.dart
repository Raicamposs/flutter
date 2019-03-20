import 'package:conversor_moedas/componentes.dart';
import 'package:conversor_moedas/conversor_service.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with componentes {
  double dolar = 0;
  double euro = 0;

  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  void _realChanged(String text) {
    dolarController.text = (double.parse(text) / this.dolar).toStringAsFixed(2);
    euroController.text = (double.parse(text) / this.euro).toStringAsFixed(2);
  }

  void _dolarChanged(String text) {
    realController.text = (double.parse(text) * this.dolar).toStringAsFixed(2);
    euroController.text =
        (double.parse(text) * this.dolar / this.euro).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    realController.text = (double.parse(text) * this.euro).toStringAsFixed(2);
    dolarController.text =
        (double.parse(text) * this.euro / this.dolar).toStringAsFixed(2);
  }

  Widget conversor(snapshot) {
    dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
    euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];

    return SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.all(30),
      child: Column(
        children: <Widget>[
          Divider(
            height: 30,
          ),
          CircleAvatar(
            backgroundColor: Colors.amber,
            radius: 80,
            child: Center(
              child: Icon(
                Icons.attach_money,
                color: Colors.white,
                size: 150.00,
              ),
            ),
          ),
          Divider(
            height: 30,
          ),
          BuiderTextField("Reais", "R\$", realController, _realChanged),
          Divider(),
          BuiderTextField("Dolar", "US\$", dolarController, _dolarChanged),
          Divider(),
          BuiderTextField("Euro", "€", euroController, _euroChanged),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black26,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.amber,
          actions: <Widget>[
            Icon(
              Icons.attach_money,
              color: Colors.white,
            )
          ],
          title: Text(
            'Conversor de Moedas',
            style: TextStyle(fontWeight: FontWeight.w100, color: Colors.white),
          ),
        ),
        body: FutureBuilder<Map>(
            future: getData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return LabelCentral('Carregando Dados ...');
                default:
                  if (snapshot.hasError) {
                    return LabelCentral('Erro ao Carregar Dados  !');
                  } else {
                    return conversor(snapshot);
                  }
              }
            }));
  }
}
