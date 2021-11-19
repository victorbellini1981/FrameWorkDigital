import 'dart:io';
import 'dart:typed_data';

import 'package:appframework/src/public/globals.dart';
import 'package:appframework/src/views/carrinho.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class Final extends StatefulWidget {
  @override
  _FinalState createState() => _FinalState();
}

Future<void> geradorPdf() async {
  final pdf = pw.Document();

  pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Text(
            'Hello World',
          ),
        ); // Center
      })); // Page

  final output = await getTemporaryDirectory();
  final file = File("${output.path}/example.pdf");
  await file.writeAsBytes(await pdf.save());
}

class _FinalState extends State<Final> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cupom = Container(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 0.4,
        child: ListView.builder(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          itemCount: frutas.length,
          itemBuilder: (BuildContext context, int index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    frutas[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 20,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    'R\$ ' +
                        precos[index].toStringAsFixed(2).replaceAll('.', ','),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 20,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
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
            'COMPROVANTE',
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Carrinho()));
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
                SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Text(
                          "Produto",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(
                          "Preço",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: cupom,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Total: R\$ ' +
                        total.toStringAsFixed(2).replaceAll('.', ','),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 20,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                        color: Colors.orange[800],
                        child: Center(
                          child: Text(
                            "Gerar PDF",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onPressed: geradorPdf,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)))),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
