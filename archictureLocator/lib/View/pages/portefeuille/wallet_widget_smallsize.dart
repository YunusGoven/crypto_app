import 'package:flutter/material.dart';
import 'package:mvvm/Model/wallet.dart';

class WalletSmallSize extends StatelessWidget {
  final Wallet model;
  const WalletSmallSize({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              model.name.length <= 7 ? model.name : model.cryptoId,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(
              width: 50,
            ),
            Text("${model.number} ${model.cryptoId}"),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${model.percent} %',
              style: TextStyle(
                color: model.percent < 0 ? Colors.red : Colors.green,
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Text('${model.gainsPertes} \$',
                style: TextStyle(
                  color: model.percent < 0 ? Colors.red : Colors.green,
                )),
            const SizedBox(
              width: 30,
            ),
            Text('${model.gainsPertesTotal} \$')
          ],
        ),
      ],
    );
  }
}
