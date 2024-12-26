import 'package:conversor_moedas/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const req = 'https://api.hgbrasil.com/finance?key=faf4a310';

void main() async {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

Future<Map> getData() async {
  http.Response res = await http.get(Uri.parse(req));
  return json.decode(res.body);
}
