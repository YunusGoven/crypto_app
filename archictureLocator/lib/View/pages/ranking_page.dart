import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/Services/navigation_service.dart';
import 'package:mvvm/Services/userinfo_service.dart';
import 'package:mvvm/View/widgets/classement_widget.dart';
import 'package:mvvm/ViewModel/ranking_viewmodel.dart';
import 'package:mvvm/locator.dart';
import 'package:stacked/stacked.dart';

class RankingPage extends StatelessWidget {
  const RankingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ClassementViewModel>.reactive(
      viewModelBuilder: () => ClassementViewModel(),
      onModelReady: (model) => model.getClassement(),
      builder: (context, model, child) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 30,
            runSpacing: 30,
            children: <Widget>[
              if (model.users == null) LinearProgressIndicator(),
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
