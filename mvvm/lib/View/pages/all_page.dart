import 'dart:async';
import 'package:flutter/material.dart';
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
    done();
    Timer.periodic(Duration(seconds: 25), (timer) {
      if (!_cryptoStreamController.isClosed) {
        done();
      } else {
        timer.cancel();
      }
    });
  }

  done() async {
    List<CryptoViewModel> cr = await _cvm.getAllCryptos(15);
    if (!_cryptoStreamController.isClosed) {
      _cryptoStreamController.sink.add(cr);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _cryptoStreamController.close();
  }

  @override
  void deactivate() {
    super.deactivate();
    _cryptoStreamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          CryptoListWidget(
            cryptoController: _cryptoStreamController,
          ),
        ],
      ),
    ));
  }
}
