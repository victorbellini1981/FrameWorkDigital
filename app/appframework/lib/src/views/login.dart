import 'package:appframework/core/utils.dart';
import 'package:appframework/src/models/Frutas.dart';
import 'package:appframework/src/public/globals.dart';
import 'package:appframework/src/views/inicial.dart';
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
    getUrlServidor().then((value) {
      lista();
    });
  }

  lista() async {
    Map obj = Map();
    Map retorno = await promessa(_scaffoldKey, 'GetFrutas', obj);
    if (retorno['situacao'] == "sucesso" && retorno['obj'].length > 0) {
      List lista = retorno['obj'];
      listaFrutas = lista.map((fruta) => Frutas.fromJson(fruta)).toList();
    }
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
                "Login:",
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
              )),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.orange,
              ),
            ),
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
              )),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.orange,
              ),
            ),
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
                "Entrar",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold),
              ),
            ),
            onPressed: () {
              if (txtlogin.text.isEmpty) {
                // ignore: deprecated_member_use
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text('Digite o seu login!'),
                  duration: Duration(seconds: 2),
                ));
              } else if (txtsenha.text.isEmpty) {
                // ignore: deprecated_member_use
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text('Digite a sua senha!'),
                  duration: Duration(seconds: 2),
                ));
              } else if (txtlogin.text != "usuariofixo") {
                // ignore: deprecated_member_use
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text('Usuário inválido!'),
                  duration: Duration(seconds: 2),
                ));
              } else if (txtsenha.text != "123") {
                // ignore: deprecated_member_use
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text('Senha inválida!'),
                  duration: Duration(seconds: 2),
                ));
              } else {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Inicial()));
              }
            },
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0))));

    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.orange[800],
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "LOGIN",
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold),
        ),
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
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        width: 5,
                        color: Colors.orange,
                      ),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            'assets/images/logo.jpeg',
                          ))),
                ),
                SizedBox(height: 10),
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
