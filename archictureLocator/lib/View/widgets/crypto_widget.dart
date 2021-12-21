import 'package:flutter/material.dart';
import 'package:mvvm/Model/models/crypto.dart';
import 'package:mvvm/View/components/image_widget.dart';

class CryptoWidget extends StatelessWidget {
  final Crypto model;
  const CryptoWidget({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(model.Name),
                SizedBox(
                  height: 10,
                ),
                LogoImage(image: model.LogoUrl),
              ],
            ),
            Column(
              children: [
                Text("${model.Price.toStringAsFixed(4)} \$",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "${model.Percent} %",
                      style: TextStyle(
                        color: model.Percent < 0 ? Colors.red : Colors.green,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      model.Percent < 0
                          ? Icons.arrow_downward_outlined
                          : Icons.arrow_upward_outlined,
                      color: model.Percent < 0 ? Colors.red : Colors.green,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
