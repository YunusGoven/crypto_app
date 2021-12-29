import 'package:flutter/material.dart';
import 'package:mvvm/Model/models/crypto.dart';
import 'package:mvvm/View/widgets/crypto_widget.dart';
import 'package:mvvm/ViewModel/crypto_viewmodel.dart';
import 'package:stacked/stacked.dart';

// ignore: must_be_immutable
class CryptoListWidget extends StatefulWidget {
  List<Crypto> cryptos;
  CryptoListWidget({Key key, this.cryptos}) : super(key: key);

  @override
  _CryptoListState createState() => _CryptoListState();
}

class _CryptoListState extends State<CryptoListWidget> {
  var controller = TextEditingController();
  var copy = <Crypto>[];
  @override
  void initState() {
    copy = widget.cryptos.toList();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 15),
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Recherche',
                labelText: 'Recherche',
                hintStyle: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
                border: OutlineInputBorder(borderSide: BorderSide()),
              ),
              onChanged: (value) {
                setState(() {
                  if (value.isEmpty) widget.cryptos = copy;

                  widget.cryptos = copy.where((element) {
                    var name = element.Name.toLowerCase()
                        .contains(value.toLowerCase());
                    var id = element.Name.toLowerCase()
                        .contains(value.toLowerCase());
                    if (name || id) return true;
                    return false;
                  }).toList();
                });
              },
            ),
          ),
          ViewModelBuilder<CryptoViewModel>.reactive(
            viewModelBuilder: () => CryptoViewModel(),
            disposeViewModel: false,
            builder: (context, model, child) => Wrap(
              spacing: 16,
              runSpacing: 16,
              children: <Widget>[
                ...widget.cryptos
                    .asMap()
                    .map((index, crypto) => MapEntry(
                          index,
                          GestureDetector(
                              child: CryptoWidget(model: crypto),
                              onTap: () => model.navigateToCrypto(crypto.Id)),
                        ))
                    .values
                    .toList()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
