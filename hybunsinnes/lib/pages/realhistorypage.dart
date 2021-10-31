import 'package:flutter/material.dart';
import 'package:hybunsinnes/model/transaction.dart';
import 'package:hybunsinnes/widgets/historywidget.dart';

class HistoryPage extends StatefulWidget {
  final List<Transaction> transactions;
  const HistoryPage({Key key, this.transactions}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 25, left: 20, right: 20, bottom: 25),
        child: Column(
          children: createWidget(),
        ),
      ),
    );
  }

  createWidget() {
    var userWidget = <Widget>[];
    widget.transactions.forEach((element) {
      var wi = HistoryWidget(
        transaction: element,
      );
      userWidget.add(wi);
      var divider =
          Divider(color: Colors.black, indent: 10, endIndent: 10, thickness: 5);
      userWidget.add(divider);
    });
    userWidget.removeLast();
    return userWidget;
  }
}
