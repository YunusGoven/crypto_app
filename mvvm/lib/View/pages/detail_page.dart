import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvvm/Model/models/user.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/Services/navigation_service.dart';
import 'package:mvvm/Services/userinfo_service.dart';
import 'package:mvvm/View/components/detail_graph_widget.dart';
import 'package:mvvm/View/components/detail_midde_lwidget.dart';
import 'package:mvvm/View/components/detail_up_widget.dart';
import 'package:mvvm/View/pages/discussion_page.dart';
import 'package:mvvm/ViewModel/crypto_viewmodel.dart';
import 'package:mvvm/locator.dart';

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
  final _auth = locator<Auth>();

  @override
  void initState() {
    super.initState();

    done();
    Timer.periodic(Duration(seconds: 25), (timer) {
      if (!_streamController.isClosed) {
        print("open");
        done();
      } else {
        timer.cancel();
      }
    });
  }

  done() async {
    CryptoViewModel cr = await _cvm.getCrypto(widget.cryptoId);
    if (!_streamController.isClosed) {
      _streamController.sink.add(cr);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
    print("Dispose");
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    _streamController.close();
    print("Deac");
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
                  child: LinearProgressIndicator(),
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
                          height: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Converter",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            CalculatorWidget(cryptoValue: snapdata.data),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Graph(crypto: snapdata.data),
                        SizedBox(
                          height: 50,
                        ),
                        FutureBuilder<bool>(
                          future: _auth.isAuthenticate(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data) {
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                        FloatingActionButton.extended(
                                          onPressed: () {
                                            locator<NavigationService>()
                                                .navigateTo(
                                                    MessagingRoute,
                                                    queryParams: {
                                                  'cryptoId': widget.cryptoId
                                                });
                                          },
                                          label: Text(""),
                                          icon: Icon(Icons.message),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              }
                            }
                            return Container();
                          },
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

class CalculatorWidget extends StatefulWidget {
  final CryptoViewModel cryptoValue;
  CalculatorWidget({Key key, this.cryptoValue}) : super(key: key);

  @override
  _CalculatorWidgetState createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  final _controllerMonet = TextEditingController();
  final _controllerCrypto = TextEditingController();
  static const _locale = 'en';
  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;

  @override
  Widget build(BuildContext context) {
    var value = widget.cryptoValue.Price;
    return Row(
      children: [
        Text("Money"),
        Expanded(
          child: TextField(
            controller: _controllerMonet,
            decoration: InputDecoration(prefixText: _currency),
            keyboardType: TextInputType.number,
            onChanged: (string) {
              print(string);
              if (string.isEmpty) {
                _controllerCrypto.text = '';
                _controllerCrypto.clear();
              } else {
                var val = (double.tryParse(
                          string,
                        ) /
                        value)
                    .toStringAsFixed(8);

                _controllerCrypto.value = TextEditingValue(
                  text: val,
                );
              }
            },
          ),
        ),
        Icon(Icons.swap_horiz),
        Text("Crypto"),
        Expanded(
          child: TextField(
            controller: _controllerCrypto,
            decoration: InputDecoration(prefixText: widget.cryptoValue.Id),
            keyboardType: TextInputType.number,
            onChanged: (string) {
              if (string.isEmpty) {
                _controllerMonet.text = '';
                _controllerMonet.clear();
              } else {
                var val = (double.tryParse(string) * value).toStringAsFixed(4);
                _controllerMonet.value = TextEditingValue(
                  text: val,
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
