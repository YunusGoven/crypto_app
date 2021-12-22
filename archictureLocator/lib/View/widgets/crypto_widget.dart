import 'package:flutter/material.dart';
import 'package:mvvm/Model/models/crypto.dart';
import 'package:mvvm/View/components/image_widget.dart';

class CryptoWidget extends StatelessWidget {
  final Crypto model;
  const CryptoWidget({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 5,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                LogoImage(image: model.LogoUrl),
                SizedBox(
                  width: 60,
                ),
                if (size < 380) Text(model.Name),
              ],
            ),
            if (size >= 380) Text(model.Name),
            Row(
              children: [
                if (size >= 800) showHistory("30 Jours", model.D30Price, model),
                if (size >= 750) showHistory("7 Jours", model.D7Price, model),
                if (size >= 700) showHistory("1 Jours", model.D1Price, model),
                if (size >= 650) showHistory("1 Heure", model.H1Price, model),
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

  Widget showHistory(String time, num value, Crypto cryptoModel) {
    value = cryptoModel.Price + value;
    return Row(
      children: [
        SizedBox(
          width: 40,
        ),
        Column(
          children: [
            Text(
              time,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "${value.toStringAsFixed(4)} \$",
              style: TextStyle(
                color: cryptoModel.Price > value ? Colors.red : Colors.green,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
