import 'package:appframework/src/public/globals.dart';
import 'package:appframework/src/views/final.dart';
import 'package:appframework/src/views/inicial.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Carrinho extends StatefulWidget {
  @override
  _CarrinhoState createState() => _CarrinhoState();
}

class _CarrinhoState extends State<Carrinho> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  ScrollController _controllerLista;

  @override
  void initState() {
    _controllerLista = ScrollController();
    super.initState();
  }

  final itemSize = 130.0;
  int item = 0;

  @override
  Widget build(BuildContext context) {
    final listaCarrinho = Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.7,
        child: ListView.builder(
          controller: _controllerLista,
          itemExtent: itemSize,
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          itemCount: carrinho.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {},
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.orange)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 110,
                          height: 110,
                          child: Image.network(
                            carrinho[index].imagem,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.red)),
                              );
                            },
                          ),
                        ),
                        Expanded(
                            child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                children: [
                                  Text(carrinho[index].nome,
                                      style: TextStyle(
                                          color: Color(0xff472c24),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'R\$ ' +
                                        carrinho[index]
                                            .preco
                                            .toStringAsFixed(2)
                                            .replaceAll('.', ','),
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xff472c24),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      color: Color(0xfec9492),
                      width: 40,
                      height: 40,
                      child: IconButton(
                          iconSize: 40,
                          icon: Image.asset('assets/images/lixeira.png'),
                          onPressed: () {
                            item = index;
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  _buildAboutDialog2(context),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            );
          },
        ));

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
            'CARRINHO',
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          leading: IconButton(
            onPressed: () {
              frutas = [];
              precos = [];
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Inicial()));
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
                  alignment: Alignment.center,
                  child: listaCarrinho,
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                        color: Colors.orange[800],
                        child: Center(
                          child: Text(
                            "Finalizar",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onPressed: () {
                          total = 0.0;
                          frutas = [];
                          precos = [];
                          for (var i = 0; i < carrinho.length; i++) {
                            frutas.add(carrinho[i].nome);
                            precos.add(carrinho[i].preco);
                            total += precos[i];
                          }
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Final()));
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)))),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Widget _buildAboutDialog2(BuildContext context) {
    return Dialog(
        elevation: 10,
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            Container(
              color: Colors.orange[100],
              padding: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Text(
                    "Deseja excluir esse ítem?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xff472c24),
                        fontSize: 25,
                        fontFamily: 'Montserrat'),
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                              width: MediaQuery.of(context).size.width / 4,
                              margin: EdgeInsets.only(left: 20),
                              // ignore: deprecated_member_use
                              child: RaisedButton(
                                color: Colors.orange,
                                child: Center(
                                  child: Text(
                                    "Sim",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'Montserrat'),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    carrinho.remove(carrinho[item]);
                                  });
                                  Navigator.of(context).pop();
                                },
                              )),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                              width: MediaQuery.of(context).size.width / 4,
                              margin: EdgeInsets.only(right: 20),
                              // ignore: deprecated_member_use
                              child: RaisedButton(
                                color: Colors.orange,
                                child: Center(
                                  child: Text(
                                    "Não",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'Montserrat'),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
