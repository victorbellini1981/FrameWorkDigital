import 'package:appframework/src/public/globals.dart';
import 'package:appframework/src/views/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Inicial extends StatefulWidget {
  @override
  _InicialState createState() => _InicialState();
}

class _InicialState extends State<Inicial> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  ScrollController _controllerProd;

  @override
  void initState() {
    _controllerProd = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final listadefrutas = listaFrutas.length == 0
        ? Center(
            child: Text('Nenhum ítem disponível'),
          )
        : Container(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 0.7,
            child: GridView.count(
                controller: _controllerProd,
                crossAxisCount: 2,
                childAspectRatio: (300 / 550),
                children: List.generate(listaFrutas.length, (index) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    margin: (index % 2) == 0
                        ? EdgeInsets.only(right: 3, top: 5)
                        : EdgeInsets.only(left: 3, top: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.orange,
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        InkWell(
                          child: Container(
                            alignment: Alignment.topCenter,
                            height: MediaQuery.of(context).size.height / 3,
                            child: Image.network(
                              listaFrutas[index].imagem,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.orange)),
                                );
                              },
                            ),
                          ),
                          onTap: () {},
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(listaFrutas[index].nome,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color(0xff472c24),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                              'R\$ ' +
                                  listaFrutas[index].preco.toStringAsFixed(2),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color(0xff472c24),
                                fontSize: 20,
                              )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: 100,
                            height: 30,
                            // ignore: deprecated_member_use
                            child: RaisedButton(
                              color: Colors.orange,
                              child: Center(
                                child: Text(
                                  "ADICIONAR",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
                                ),
                              ),
                              onPressed: () {},
                            ))
                      ],
                    ),
                  );
                })));

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
          child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.orange,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'LISTA DE FRUTAS',
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          leading: IconButton(
            onPressed: () {
              listaFrutas = [];
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: listadefrutas,
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
