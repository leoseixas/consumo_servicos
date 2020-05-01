import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _cep = TextEditingController();
  String _resultado = "Resultado";


  _recuperarCep() async {
    String cepDigitado = _cep.text;
    String url = "https://viacep.com.br/ws/${cepDigitado}/json/";
    http.Response response;
    response = await http.get(url);
    Map<String, dynamic> retorno = json.decode(response.body);

    String cep = retorno["cep"];
    String logradouro = retorno["logradouro"];
    String complemento = retorno["complemento"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];
    String uf = retorno["uf"];

    setState(() {
      _resultado = "${cep}, ${logradouro}, ${complemento}, ${bairro}, ${localidade}, ${uf}";
    });

    print(
      "Resposta cep: ${cep} logradouro: ${logradouro}, complemento: ${complemento}, bairro: ${bairro}, localidade: ${localidade}, uf ${uf},  "
    );

//    print("resposta: " + response.body);
//    print("resposta: " + response.statusCode.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de serviço WEB"),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Numero do Cep"
              ),
              style: TextStyle(
                fontSize: 20
              ),
              controller: _cep,
            ),
            RaisedButton(
              child: Text("Pressione o botao"),
                onPressed: _recuperarCep,
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                _resultado,
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
