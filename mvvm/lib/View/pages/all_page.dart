import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mvvm/View/widgets/crypto_list_widget.dart';
import 'package:mvvm/ViewModel/crypto_viewmodel.dart';

class AllCryptoPage extends StatefulWidget {
  const AllCryptoPage({Key key}) : super(key: key);

  @override
  _AllCryptoPageState createState() => _AllCryptoPageState();
}

class _AllCryptoPageState extends State<AllCryptoPage> {
  final StreamController<List<CryptoViewModel>> _cryptoStreamController =
      StreamController();
  final CryptoViewModel _cvm = CryptoViewModel();

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 20), (timer) {
      done();
    });
  }

  done() async {
    List<CryptoViewModel> cr = await _cvm.getAllCryptos(15);
    _cryptoStreamController.sink.add(cr);
  }

  @override
  void dispose() {
    _cryptoStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CryptoListWidget(
            cryptoController: _cryptoStreamController,
          ),
        ],
      ),
    ));
  }
}
