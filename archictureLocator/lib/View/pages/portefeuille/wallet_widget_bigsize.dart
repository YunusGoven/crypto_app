import 'package:flutter/material.dart';
import 'package:mvvm/Model/wallet.dart';

class WalletBigSize extends StatelessWidget {
  final Wallet model;
  const WalletBigSize({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              const Text(
                'Nom',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                model.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Column(
            children: [
              const Text(
                'Nombre',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Text("${model.number} ${model.cryptoId}"),
            ],
          ),
          Column(
            children: [
              const Text(
                'G/P %',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${model.percent} %',
                style: TextStyle(
                  color: model.percent < 0 ? Colors.red : Colors.green,
                ),
              ),
            ],
          ),
          Column(
            children: [
              const Text(
                'G/P \$',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Text('${model.gainsPertes} \$',
                  style: TextStyle(
                    color: model.percent < 0 ? Colors.red : Colors.green,
                  )),
            ],
          ),
          Column(
            children: [
              const Text(
                'Total',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Text('${model.gainsPertesTotal} \$')
            ],
          ),
        ],
      ),
    );
  }
}
