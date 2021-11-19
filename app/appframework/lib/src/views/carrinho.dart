import 'package:appframework/src/public/globals.dart';
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

  @override
  Widget build(BuildContext context) {
    final listaCarrinho = Container(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height / 1.8,
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
                        border: Border.all(width: 1, color: Color(0xf472c24))),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  Text(carrinho[index].nome,
                                      style: TextStyle(
                                          color: Color(0xff472c24),
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 8),
                                child: Text(
                                  'R\$ ' +
                                      carrinho[index]
                                          .preco
                                          .toStringAsFixed(2)
                                          .replaceAll('.', ','),
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Color(0xff472c24),
                                      fontWeight: FontWeight.bold),
                                ),
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
                      width: 35,
                      height: 35,
                      child: IconButton(
                          iconSize: 35,
                          icon: Image.asset('assets/images/lixeira.png'),
                          onPressed: () {}),
                    ),
                  ),
                ],
              ),
            );
          },
        ));

    return Container();
  }
}
