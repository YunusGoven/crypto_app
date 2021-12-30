import 'package:flutter/material.dart';
import 'package:mvvm/View/pages/classement/classement_widget.dart';
import 'package:mvvm/ViewModel/ranking_viewmodel.dart';
import 'package:stacked/stacked.dart';

class RankingPage extends StatelessWidget {
  const RankingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ClassementViewModel>.reactive(
      viewModelBuilder: () => ClassementViewModel(),
      onModelReady: (model) => model.getClassement(),
      disposeViewModel: false,
      builder: (context, model, child) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 30,
            runSpacing: 30,
            children: <Widget>[
              if (model.users == null) const LinearProgressIndicator(),
              if (model.users != null)
                ...model.users
                    .asMap()
                    .map((index, user) => MapEntry(
                          index,
                          UserClassementWidget(
                            model: user,
                            pos: index + 1,
                          ),
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
