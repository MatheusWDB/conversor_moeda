import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const req = 'https://api.hgbrasil.com/finance?key=faf4a310';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController realController = TextEditingController();
  TextEditingController dolarController = TextEditingController();
  TextEditingController euroController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('\$ Conversor \$'),
          backgroundColor: Colors.amber,
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: Text(
                    'Carregando...!',
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 25.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Erro ao carregar!',
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 25.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                double dolar =
                    snapshot.data!['results']['currencies']['USD']['buy'];
                double euro =
                    snapshot.data!['results']['currencies']['EUR']['buy'];
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      spacing: 8.0,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Icon(
                          Icons.monetization_on,
                          size: 150.0,
                          color: Colors.amber,
                        ),
                        TextField(
                          controller: realController,
                          cursorColor: Colors.amber,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 25.0,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Reais',
                            prefixText: 'R\$ ',
                            labelStyle: TextStyle(
                              color: Colors.amber,
                              fontSize: 25.0,
                            ),
                            prefixStyle: TextStyle(
                              color: Colors.amber,
                              fontSize: 25.0,
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        TextField(
                          controller: dolarController,
                          cursorColor: Colors.amber,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 25.0,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Dólares',
                            prefixText: 'U\$ ',
                            labelStyle: TextStyle(
                              color: Colors.amber,
                              fontSize: 25.0,
                            ),
                            prefixStyle: TextStyle(
                              color: Colors.amber,
                              fontSize: 25.0,
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        TextField(
                          controller: euroController,
                          cursorColor: Colors.amber,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 25.0,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Euros',
                            prefixText: '€ ',
                            labelStyle: TextStyle(
                              color: Colors.amber,
                              fontSize: 25.0,
                            ),
                            prefixStyle: TextStyle(
                              color: Colors.amber,
                              fontSize: 25.0,
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}

Future<Map> getData() async {
  http.Response res = await http.get(Uri.parse(req));
  return json.decode(res.body);
}
