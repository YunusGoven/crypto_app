import 'package:flutter/material.dart';
import 'package:mvvm/View/pages/historique/history_list_widget.dart';
import 'package:mvvm/ViewModel/history_viewmodel.dart';
import 'package:stacked/stacked.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HistoryViewModel>.reactive(
      viewModelBuilder: () => HistoryViewModel(),
      onModelReady: (model) => model.getHistory(),
      disposeViewModel: false,
      builder: (context, model, child) => RefreshIndicator(
          onRefresh: () {
            return Future.delayed(const Duration(seconds: 1), () {
              setState(() {
                model.getHistory();
              });
            });
          },
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              model.history == null
                  ? const CircularProgressIndicator()
                  : HistoryListWidget(historys: model.history),
            ],
          ))),
    );
  }
}
