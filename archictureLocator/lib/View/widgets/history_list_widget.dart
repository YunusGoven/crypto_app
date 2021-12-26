import 'package:flutter/material.dart';
import 'package:mvvm/Model/models/history.dart';
import 'package:mvvm/View/widgets/history_widget.dart';
import 'package:mvvm/ViewModel/history_viewmodel.dart';
import 'package:stacked/stacked.dart';

class HistoryListWidget extends StatelessWidget {
  final List<History> historys;
  const HistoryListWidget({Key key, this.historys}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HistoryViewModel>.reactive(
      viewModelBuilder: () => HistoryViewModel(),
      builder: (context, model, child) => Wrap(
        spacing: 30,
        runSpacing: 30,
        children: <Widget>[
          ...historys
              .asMap()
              .map((index, h) => MapEntry(
                    index,
                    HistoryWidget(model: h),
                  ))
              .values
              .toList()
        ],
      ),
    );
  }
}
