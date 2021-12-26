import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvvm/Model/models/history.dart';

class HistoryWidget extends StatelessWidget {
  final History model;
  const HistoryWidget({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime ui = DateTime.tryParse(model.dateTransaction);
    String formated = DateFormat('dd-MM-yyyy').format(ui);
    return Container(
      padding: EdgeInsets.only(bottom: 10, left: 40, top: 10, right: 40),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(
                model.type,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
              Text(formated),
            ],
          ),
          Text(
            model.type == "VENTE"
                ? model.number.toString() + model.cryptoId
                : model.value.toString() + model.cryptoId,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
          ),
          Column(
            children: [
              Text(
                model.type == "VENTE"
                    ? model.value.toString() + "\$"
                    : model.number.toString() + "\$",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 5,
              ),
              Text(model.onTransactionValue.toString() +
                  "\$ /1 " +
                  model.cryptoId),
            ],
          ),
        ],
      ),
    );
  }
}
