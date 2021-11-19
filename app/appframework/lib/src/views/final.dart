import 'dart:typed_data';

import 'package:appframework/src/models/Frutas.dart';
import 'package:appframework/src/public/globals.dart';
import 'package:appframework/src/views/carrinho.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Final extends StatefulWidget {
  @override
  _FinalState createState() => _FinalState();
}

/* Future<void> geradorPdf() async {
  print("gerar pdf");
  final pdf = pw.Document();

  final pw.Font customfont = pw.Font.ttf(
      await rootBundle.load('assets/fonts/OpenSans/OpenSans-Regular.ttf'));

  pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Text('Hello World',
              style: pw.TextStyle(font: customfont, fontSize: 40)),
        ); // Center
      })); // Page
  PdfPreview(
    build: (format) => pdf.save(),
  );

  /* final output = await getTemporaryDirectory();
  final file = File("${output.path}/example.pdf");
  await file.writeAsBytes(await pdf.save()); */
} */

class _FinalState extends State<Final> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  List<pw.Widget> _buildContent(pw.Context context) {
    return [
      pw.Padding(
          padding: pw.EdgeInsets.only(top: 50, left: 25, right: 25),
          child: _contentFrutas(context)),
    ];
  }

  pw.Widget _contentFrutas(pw.Context context) {
    // Define uma lista usada no cabeçalho
    const tableHeaders = ['Produto', 'Preço'];

    return pw.Table.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: pw.BoxDecoration(),
      headerHeight: 25,
      cellHeight: 40,
      // Define o alinhamento das células, onde a chave é a coluna
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
      },
      // Define um estilo para o cabeçalho da tabela
      headerStyle: pw.TextStyle(
        fontSize: 30,
        color: PdfColors.orange,
        fontWeight: pw.FontWeight.bold,
      ),
      // Define um estilo para a célula
      cellStyle: const pw.TextStyle(
        fontSize: 30,
      ),
      // Define a decoração
      rowDecoration: pw.BoxDecoration(),
      headers: tableHeaders,
      // retorna os valores da tabela, de acordo com a linha e a coluna
      data: List<List<String>>.generate(
        frutas.length,
        (row) => List<String>.generate(
          tableHeaders.length,
          (col) => _getValueIndex(frutas[row], col),
        ),
      ),
    );
  }

  String _getValueIndex(Frutas fruta, int col) {
    switch (col) {
      case 0:
        return fruta.nome;
      case 1:
        return _formatValue(fruta.preco);
    }
    return '';
  }

  pw.Widget _buildPrice(pw.Context context) {
    return pw.Container(
      color: PdfColors.orange,
      height: 130,
      child: pw.Row(
          //crossAxisAlignment: pw.CrossAxisAlignment.center,
          mainAxisAlignment: pw.MainAxisAlignment.end,
          children: [
            pw.Padding(
                padding: pw.EdgeInsets.all(10),
                child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Padding(
                          padding: pw.EdgeInsets.only(bottom: 0, right: 0),
                          child: pw.Text('TOTAL',
                              textAlign: pw.TextAlign.right,
                              style: pw.TextStyle(
                                  color: PdfColors.white, fontSize: 40))),
                      pw.Text('${_formatValue(total)}',
                          textAlign: pw.TextAlign.right,
                          style: pw.TextStyle(
                              color: PdfColors.white, fontSize: 40))
                    ]))
          ]),
    );
  }

  /// Formata o valor informado na formatação pt/BR
  String _formatValue(double value) {
    final NumberFormat numberFormat = new NumberFormat("R\$ #,##0.00", "pt_BR");
    return numberFormat.format(value);
  }

  @override
  Widget build(BuildContext context) {
    Future<Uint8List> geradorPdf(PdfPageFormat format) async {
      final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);

      pdf.addPage(
        pw.MultiPage(
          pageFormat: format,
          footer: _buildPrice,
          build: (context) => _buildContent(context),
        ),
      );
      return pdf.save();
    }

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
        body: PdfPreview(
          build: (format) => geradorPdf(format),
        ),
        /* SingleChildScrollView(
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
        ), */
      )),
    );
  }
}
