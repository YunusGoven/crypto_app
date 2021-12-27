import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvvm/Model/models/history.dart';

class HistoryWidget extends StatelessWidget {
  final History model;
  const HistoryWidget({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color colors1 = model.type == "VENTE" ? Colors.red : Colors.green;
    Color colors2 = model.type == "VENTE" ? Colors.green : Colors.red;
    var screenSize = MediaQuery.of(context).size;
    var screenwidht = screenSize.width;
    DateTime ui = DateTime.tryParse(model.dateTransaction);
    String formated = DateFormat('dd-MM-yyyy').format(ui);
    return Container(
      padding: const EdgeInsets.only(bottom: 10, left: 40, top: 10, right: 40),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 5,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(
                model.type,
                style: screenwidht >= 895
                    ? const TextStyle(fontWeight: FontWeight.bold, fontSize: 25)
                    : const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Text(formated),
            ],
          ),
          Text(
            model.type == "VENTE"
                ? model.number.toString() + "   " + model.cryptoId
                : model.value.toString() + "   " + model.cryptoId,
            style: screenwidht >= 895
                ? TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 30, color: colors1)
                : TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20, color: colors1),
          ),
          Column(
            children: [
              Text(
                model.type == "VENTE"
                    ? model.value.toString() + "\$"
                    : model.number.toString() + "\$",
                style: screenwidht >= 895
                    ? TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: colors2)
                    : TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: colors2),
              ),
              const SizedBox(
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
