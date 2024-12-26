import 'package:conversor_moedas/widgets/build_text_field.dart';
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

  late double dolar;
  late double euro;

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
                dolar = snapshot.data!['results']['currencies']['USD']['buy'];
                euro = snapshot.data!['results']['currencies']['EUR']['buy'];
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
                        BuildTextField(
                          label: 'Reais',
                          prefix: 'R\$ ',
                          controller: realController,
                          function: realChanged,
                        ),
                        BuildTextField(
                          label: 'Dólares',
                          prefix: 'U\$ ',
                          controller: dolarController,
                          function: dolarChanged,
                        ),
                        BuildTextField(
                          label: 'Euros',
                          prefix: '€ ',
                          controller: euroController,
                          function: euroChanged,
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

  void realChanged(String text) {}
  void dolarChanged(String text) {}
  void euroChanged(String text) {}
}

Future<Map> getData() async {
  http.Response res = await http.get(Uri.parse(req));
  return json.decode(res.body);
}
