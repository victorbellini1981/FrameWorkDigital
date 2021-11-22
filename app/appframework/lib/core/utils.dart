import 'dart:async';

import 'package:appframework/src/public/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: missing_return
Future<String> getUrlServidor() async {
  configApp.urlServidor = "http://192.168.0.106:8080/testeFrameWork/";
}

Future<Map<String, dynamic>> promessa(
    GlobalKey<ScaffoldState> scaffoldKey, String servico, Object obj) async {
  String objjson = json.encode(obj);

  String url =
      // ignore: unnecessary_brace_in_string_interps
      "${configApp.urlServidor}${configApp.servlet}?metodo=${servico}&obj=${objjson}";
  //String url = "${configApp.urlServidor}/${configApp.servlet}?tela=${servico}";
  //print(url);

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    try {
      return json.decode(response.body);
    } catch (e) {
      //throw Exception('Formato inválido de retorno');
      // ignore: deprecated_member_use
      scaffoldKey.currentState.showSnackBar(new SnackBar(
          content: new Text(
              "Falha ao ler dados do servidor! Verifique sua conexão com a internet.")));

      return null;
    }
  } else {
    //throw Exception('Failed to load post');
    // ignore: deprecated_member_use
    scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text(
            "Falha de comunicação! Verifique sua conexão com a internet.")));
    return null;
  }
}
