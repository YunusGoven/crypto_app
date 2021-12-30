import 'package:flutter/material.dart';
import 'package:mvvm/Model/crypto.dart';
import 'package:mvvm/Services/api_service.dart';
import 'package:mvvm/Services/userinfo_service.dart';
import 'package:mvvm/locator.dart';

class BuyButtonWidget extends StatefulWidget {
  final Crypto crypto;

  const BuyButtonWidget({Key key, this.crypto}) : super(key: key);

  @override
  BuyButtonWidgetState createState() => BuyButtonWidgetState();
}

class BuyButtonWidgetState extends State<BuyButtonWidget> {
  final _formKey = GlobalKey<FormState>();
  final _numberController = TextEditingController();
  num _userSolde;
  num _total = 0;
  String _error = '';
  final _auth = locator<Auth>();
  final _api = locator<ApiService>();
  @override
  void initState() {
    super.initState();
    _userSolde = _auth.getUserSolde;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text('Acheter ${widget.crypto.Name}'),
      content: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    validator: (value) {
                      try {
                        var encoded = num.parse(value);
                        if (encoded <= 0) {
                          _error =
                              "Veuillez entrez un montant plus grand que 0";

                          return _error;
                        }
                        if (encoded > _userSolde) {
                          _error =
                              "Vous pouvez acheter au max  pour $_userSolde \$";
                          return _error;
                        }
                        _error = '';
                        return null;
                      } catch (ex) {
                        _error = "Veuillez ne pas encoder des lettres !";
                        return _error;
                      }
                    },
                    controller: _numberController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(8.0),
                      labelText: 'Nombre',
                      hintText: '50000',
                      labelStyle: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                      hintStyle: const TextStyle(
                        fontSize: 14.0,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      floatingLabelStyle: const TextStyle(
                        fontSize: 18.0,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1.5),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (String value) {
                      setState(() {
                        if (value.isEmpty) {
                          _total = 0;
                          _error = '';
                        } else {
                          try {
                            var number = num.parse(_numberController.text);
                            _total = number / widget.crypto.Price;
                            _total = num.parse(_total.toStringAsFixed(8));
                            if (number > _userSolde) {
                              _error = 'Max: $_userSolde';
                            } else {
                              _error = '';
                            }
                          } on Exception {
                            _error = 'Veuillez ne pas encoder des lettres !';
                            _total = 0;
                          }
                        }
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Text("\$")
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "max: $_userSolde \$",
              textAlign: TextAlign.end,
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
                "Valeur Actuelle : ${widget.crypto.Price.toStringAsFixed(3)} \$"),
            Text("Total: $_total ${widget.crypto.Id}"),
            const SizedBox(
              height: 40,
            ),
            Text(
              _error,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    var number = _numberController.value.text;
                    var send = await _api.buy(widget.crypto.Id,
                        num.parse(number), widget.crypto.Price, _total);

                    final snackBar = SnackBar(
                      content: Text(
                        send.value,
                        style: const TextStyle(fontSize: 20),
                      ),
                      backgroundColor:
                          send.code == 200 ? Colors.green : Colors.red,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    if (send.code != 200) {
                      _error = send.value;
                    } else {
                      Navigator.of(context).pop();
                    }
                  }
                },
                child: const Text(
                  "Acheter",
                )),
          ],
        ),
      ),
    );
  }
}
