import 'package:flutter/material.dart';
import 'package:mvvm/Model/models/crypto.dart';
import 'package:mvvm/Model/models/wallet.dart';
import 'package:mvvm/Services/api_response.dart';
import 'package:mvvm/Services/api_service.dart';
import 'package:mvvm/Services/userinfo_service.dart';
import 'package:mvvm/locator.dart';

class SellButtonWidget extends StatefulWidget {
  final Crypto crypto;

  const SellButtonWidget({Key key, this.crypto}) : super(key: key);

  @override
  SellButtonWidgetState createState() => SellButtonWidgetState();
}

class SellButtonWidgetState extends State<SellButtonWidget> {
  final _formKey = GlobalKey<FormState>();
  final _numberController = TextEditingController();
  num _userSolde;
  num _total = 0;
  String _error = '';
  final _auth = locator<Auth>();
  final _api = locator<ApiService>();

  Future<ConnectedWallet> _wallet;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _wallet = _auth.getThisWallet(widget.crypto.Id);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.crypto.Id);
    return AlertDialog(
        scrollable: true,
        title: Text('Vendre ${widget.crypto.Name}'),
        content: FutureBuilder<ConnectedWallet>(
            future: _wallet,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                default:
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  else if (snapshot.data == null) {
                    return Text(
                        'Vous ne possedez pas de ${widget.crypto.Name}');
                  } else
                    _userSolde = snapshot.data.number;
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        right: -40.0,
                        top: -80.0,
                        child: InkResponse(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: CircleAvatar(
                            child: Icon(Icons.close),
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ),
                      Form(
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
                                              "Vous pouvez vendre au max  pour $_userSolde ${widget.crypto.Id}";
                                          return _error;
                                        }
                                        _error = '';
                                        return null;
                                      } catch (ex) {
                                        _error =
                                            "Veuillez ne pas encoder des lettres !";
                                        return _error;
                                      }
                                    },
                                    controller: _numberController,
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(0.0),
                                      labelText: 'Nombre',
                                      hintText: '0.513544',
                                      labelStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14.0,
                                      ),
                                      prefixIcon: Icon(
                                        Icons.supervised_user_circle,
                                        color: Colors.black,
                                        size: 18,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade200,
                                            width: 2),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      floatingLabelStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1.5),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
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
                                            var number = num.parse(
                                                _numberController.text);
                                            //if (widget.type == "ACHAT") {
                                            _total =
                                                number * widget.crypto.Price;
                                            _total = num.parse(
                                                _total.toStringAsFixed(3));
                                            if (number > _userSolde) {
                                              _error = 'Max: ${_userSolde}';
                                            } else {
                                              _error = '';
                                            }

                                            // } else {
                                            //   _total = num.parse(_numberController.text) *
                                            //       widget.crypto.currentvalue;
                                            // }
                                          } catch (Exception) {
                                            _error =
                                                'Veuillez ne pas encoder des lettres !';
                                            _total = 0;
                                          }
                                        }
                                      });
                                    },
                                  ),
                                ),
                                Text(widget.crypto.Id)
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              "max: $_userSolde ${widget.crypto.Id}",
                              textAlign: TextAlign.end,
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                                "Valeur Actuelle : ${widget.crypto.Price.toStringAsFixed(3)} \$"),
                            Text("Total: ${_total} \$"),
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              '$_error',
                              style: TextStyle(color: Colors.red),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    var number = _numberController.value.text;
                                    var send = await _api.sell(
                                        widget.crypto.Id,
                                        num.parse(number),
                                        widget.crypto.Price,
                                        _total);

                                    final snackBar = SnackBar(
                                      content: Text(
                                        send.value,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      backgroundColor: send.code == 200
                                          ? Colors.green
                                          : Colors.red,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);

                                    if (send.code != 200) {
                                      _error = send.value;
                                    } else {
                                      Navigator.of(context).pop();
                                    }
                                  }
                                },
                                child: Text(
                                  "Vendre",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ],
                        ),
                      ),
                    ],
                  );
              }
            }));
  }
}