import 'package:flutter/material.dart';
import 'package:mvvm/View/pages/all_page/crypto_list_widget.dart';
import 'package:mvvm/ViewModel/crypto_viewmodel.dart';
import 'package:stacked/stacked.dart';

class AllCryptoPage extends StatefulWidget {
  const AllCryptoPage({Key key}) : super(key: key);

  @override
  _AllPageState createState() => _AllPageState();
}

class _AllPageState extends State<AllCryptoPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CryptoViewModel>.reactive(
        viewModelBuilder: () => CryptoViewModel(),
        onModelReady: (model) => model.getAllCryptos(-1),
        disposeViewModel: false,
        builder: (context, model, child) => RefreshIndicator(
              onRefresh: () {
                return Future.delayed(const Duration(seconds: 1), () {
                  setState(() {
                    model.getAllCryptos(-1);
                  });
                });
              },
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  model.cryptos == null
                      ? const LinearProgressIndicator()
                      : CryptoListWidget(cryptos: model.cryptos),
                ],
              )),
            ));
  }
}
