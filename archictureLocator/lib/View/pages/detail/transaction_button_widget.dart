import 'package:flutter/material.dart';
import 'package:mvvm/Model/crypto.dart';
import 'package:mvvm/Services/userinfo_service.dart';
import 'package:mvvm/View/pages/detail/buy_button_widget.dart';
import 'package:mvvm/View/pages/detail/sell_button_widget.dart';
import 'package:mvvm/locator.dart';

class TransactionButtonWidget extends StatefulWidget {
  final Crypto crypto;
  const TransactionButtonWidget({Key key, this.crypto}) : super(key: key);

  @override
  _TransactionButtonWidgetState createState() =>
      _TransactionButtonWidgetState();
}

class _TransactionButtonWidgetState extends State<TransactionButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: locator<Auth>().isAuthenticate(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data) {
            return Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FloatingActionButton.extended(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => BuyButtonWidget(
                              crypto: widget.crypto,
                            ));
                  },
                  label: const Text("Acheter"),
                  icon: const Icon(Icons.add_shopping_cart),
                ),
                const SizedBox(
                  width: 15,
                ),
                FloatingActionButton.extended(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => SellButtonWidget(
                              crypto: widget.crypto,
                            ));
                  },
                  label: const Text("Vendre"),
                  icon: const Icon(Icons.sell),
                ),
              ],
            );
          }
        }
        return Container();
      },
    );
  }
}
