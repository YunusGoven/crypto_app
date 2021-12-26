import 'package:flutter/material.dart';
import 'package:mvvm/View/widgets/history_widget.dart';
import 'package:mvvm/ViewModel/history_viewmodel.dart';
import 'package:stacked/stacked.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewModelBuilder<HistoryViewModel>.reactive(
        viewModelBuilder: () => HistoryViewModel(),
        onModelReady: (model) => model.getHistory(),
        builder: (context, model, child) => SingleChildScrollView(
          child: Wrap(
            spacing: 30,
            runSpacing: 30,
            children: <Widget>[
              ...model.history
                  .asMap()
                  .map((index, h) => MapEntry(
                        index,
                        HistoryWidget(model: h),
                      ))
                  .values
                  .toList()
            ],
          ),
        ),
      ),
    );
  }
}
