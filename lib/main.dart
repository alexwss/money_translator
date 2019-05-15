import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?format=json&key=60df7606";

void main() async{

  //this is awesome <3
  http.Response response = await http.get(request);
  print(json.decode(response.body));


  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
      hintColor: Colors.amber,
      primaryColor: Colors.white
    ),
  ));
}

//Future is like a callback
Future<Map> getData() async{
  http.Response response =  await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  double dolar, euro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: Text("\$ Conversor \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot){
            switch(snapshot.connectionState){
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: Text("Carregando dados...",
                    style: TextStyle(
                        color: Colors.amber,
                        fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ),
                );
              default:
                if(snapshot.hasError){
                  return Center(
                    child: Text("Erro ao carregando dados :(",
                      style: TextStyle(
                          color: Colors.amber,
                          fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                else{
                  dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                  euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];

                  //tela que é scroll
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Icon(Icons.monetization_on, size: 150.0, color: Colors.amber,),
                        TextField(
                          decoration: InputDecoration(
                            labelText: "Reais",
                            labelStyle: TextStyle(color: Colors.amber),
                            border: OutlineInputBorder(),
                            prefixText: "R\$"
                          ),
                          style: TextStyle(
                            color: Colors.amber
                          )
                        ),
                        Divider(),
                        TextField(
                            decoration: InputDecoration(
                                labelText: "Dolar",
                                labelStyle: TextStyle(color: Colors.amber),
                                border: OutlineInputBorder(),
                                prefixText: "US\$"
                            ),
                            style: TextStyle(
                                color: Colors.amber
                            )
                        ),
                        Divider(),
                        TextField(
                            decoration: InputDecoration(
                                labelText: "Euro",
                                labelStyle: TextStyle(color: Colors.amber),
                                border: OutlineInputBorder(),
                                prefixText: "EUR"
                            ),
                            style: TextStyle(
                                color: Colors.amber
                            )
                        ),
                      ],
                    ),
                  );
                }
            }
          }), //futureBuilder
    );//scalford
  }
}
