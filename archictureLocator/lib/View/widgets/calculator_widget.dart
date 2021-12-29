import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvvm/Model/models/crypto.dart';

class CalculatorWidget extends StatefulWidget {
  final Crypto cryptoValue;
  const CalculatorWidget({Key key, this.cryptoValue}) : super(key: key);

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
        const Text("Money"),
        Expanded(
          child: TextField(
            controller: _controllerMonet,
            decoration: InputDecoration(prefixText: _currency),
            keyboardType: TextInputType.number,
            onChanged: (string) {
              if (string.isEmpty) {
                _controllerCrypto.text = '';
                _controllerCrypto.clear();
              } else {
                var val = (double.tryParse(
                          string,
                        ) /
                        value)
                    ?.toStringAsFixed(8);

                _controllerCrypto.value = TextEditingValue(
                  text: val ?? "",
                );
              }
            },
          ),
        ),
        const Icon(Icons.swap_horiz),
        const Text("Crypto"),
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
                var val = (double.tryParse(string) * value)?.toStringAsFixed(4);
                _controllerMonet.value = TextEditingValue(
                  text: val ?? "",
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
