import 'package:flutter/material.dart';
import 'package:mvvm/View/widgets/history_list_widget.dart';
import 'package:mvvm/ViewModel/history_viewmodel.dart';
import 'package:stacked/stacked.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HistoryViewModel>.reactive(
      viewModelBuilder: () => HistoryViewModel(),
      onModelReady: (model) => model.getHistory(),
      disposeViewModel: false,
      builder: (context, model, child) => SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          model.history == null
              ? const CircularProgressIndicator()
              : HistoryListWidget(historys: model.history),
        ],
      )),
    );
  }
}
