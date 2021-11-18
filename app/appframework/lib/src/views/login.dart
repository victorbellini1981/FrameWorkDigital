import 'dart:io';
import 'package:appframework/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController txtlogin = new TextEditingController();
  TextEditingController txtsenha = new TextEditingController();

  @override
  void initState() {
    super.initState();
    getUrlServidor();
  }

  @override
  Widget build(BuildContext context) {
    final login = Container(
      width: MediaQuery.of(context).size.width * 1,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Nome:",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              )
            ],
          ),
          TextFormField(
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.orange,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.orange,
                ))),
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
            keyboardType: TextInputType.text,
            controller: txtlogin,
            validator: (value) {
              if (value.isEmpty) {
                return 'Campo obrigatório';
              }
              return null;
            },
          )
        ],
      ),
    );

    final senha = Container(
      width: MediaQuery.of(context).size.width * 1,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Senha:",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              )
            ],
          ),
          TextFormField(
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.orange,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.orange,
                ))),
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
            keyboardType: TextInputType.text,
            obscureText: true,
            controller: txtsenha,
            validator: (value) {
              if (value.isEmpty) {
                return 'Campo obrigatório';
              }
              return null;
            },
          )
        ],
      ),
    );

    final btnEnviar = SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        // ignore: deprecated_member_use
        child: RaisedButton(
            color: Colors.orange[800],
            child: Center(
              child: Text(
                "Enviar",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w300),
              ),
            ),
            onPressed: () {},
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0))));

    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.orange[800],
        automaticallyImplyLeading: true,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 30, right: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      "Cadastro de Produtos",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                login,
                SizedBox(height: 10),
                senha,
                SizedBox(height: 20),
                btnEnviar,
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
