import 'package:flutter/material.dart';
import 'package:hybunsinnes/model/transaction.dart';
import 'package:intl/intl.dart';

class HistoryWidget extends StatefulWidget {
  final Transaction transaction;
  const HistoryWidget({Key key, this.transaction}) : super(key: key);

  @override
  _HistoryWidgetState createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  @override
  Widget build(BuildContext context) {
    String formated = DateFormat('dd-mm-yyyy').format(widget.transaction.date);
    return Container(
      padding: EdgeInsets.only(bottom: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                widget.transaction.type,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
              Text(formated),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${widget.transaction.number} ${widget.transaction.type == "VENTE" ? widget.transaction.cryptoId : '\$'}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                  "${widget.transaction.total} ${widget.transaction.type == "ACHAT" ? widget.transaction.cryptoId : '\$'}"),
            ],
          ),
        ],
      ),
    );
  }
}
