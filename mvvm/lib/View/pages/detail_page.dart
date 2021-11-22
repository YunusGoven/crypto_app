import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mvvm/View/components/detail_graph_widget.dart';
import 'package:mvvm/View/components/detail_midde_lwidget.dart';
import 'package:mvvm/View/components/detail_up_widget.dart';
import 'package:mvvm/ViewModel/crypto_viewmodel.dart';

class DetailPage extends StatefulWidget {
  final String cryptoId;
  const DetailPage({Key key, @required this.cryptoId}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final StreamController<CryptoViewModel> _streamController =
      StreamController();
  final CryptoViewModel _cvm = CryptoViewModel();

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 10), (timer) {
      done();
    });
  }

  done() async {
    CryptoViewModel cr = await _cvm.getCrypto(widget.cryptoId);
    _streamController.sink.add(cr);
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: _streamController.stream,
          builder: (context, snapdata) {
            switch (snapdata.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              default:
                if (snapdata.hasError) {
                  return Text("Attend frerot");
                } else {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: 25, left: 20, right: 20, bottom: 25),
                    child: Column(
                      children: [
                        DetailUp(crypto: snapdata.data),
                        SizedBox(
                          height: 50,
                        ),
                        DetailMiddle(crypto: snapdata.data),
                        SizedBox(
                          height: 50,
                        ),
                        Graph(crypto: snapdata.data),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FloatingActionButton.extended(
                              onPressed: () {},
                              label: Text("Acheter"),
                              icon: Icon(Icons.add_shopping_cart),
                            ),
                            FloatingActionButton.extended(
                              onPressed: () {},
                              label: Text("Vendre"),
                              icon: Icon(Icons.sell),
                            ),
                          ],
                        ),
                        FloatingActionButton.extended(
                          onPressed: () {},
                          label: Text("Discussion"),
                          icon: Icon(Icons.message),
                        ),
                      ],
                    ),
                  );
                }
            }
          },
        ),
      ),
    );
  }
}
