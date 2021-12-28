import 'package:flutter/material.dart';
import 'package:mvvm/Model/models/wallet.dart';
import 'package:mvvm/View/components/image_widget.dart';

class WalletWidgetHome extends StatelessWidget {
  final Wallet model;
  const WalletWidgetHome({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[700],
          width: 5,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(
                  height: 10,
                ),
                LogoImage(image: model.imageUrl),
                Text(model.name),
              ],
            ),
            Text("${model.number} ${model.cryptoId}")
          ],
        ),
      ),
    );
  }
}
