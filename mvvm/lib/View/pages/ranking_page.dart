import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/Services/navigation_service.dart';
import 'package:mvvm/Services/userinfo_service.dart';
import 'package:mvvm/View/widgets/classement_widget.dart';
import 'package:mvvm/ViewModel/user_viewmodel.dart';
import 'package:mvvm/locator.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({Key key}) : super(key: key);

  @override
  _RankingPageState createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  final StreamController<List<ClassementViewModel>> _rankingStreamController =
      StreamController();
  final ClassementViewModel _cvm = ClassementViewModel();

  @override
  void initState() {
    verifyIsConnected();
    super.initState();
  }

  verifyIsConnected() async {
    var isAuth = await locator<Auth>().isAuthenticate();
    if (!isAuth) {
      dispose();
      locator<NavigationService>().navigateTo(HomeRoute);
    } else {
      getRanking();
    }
  }

  getRanking() async {
    List<ClassementViewModel> classement = await _cvm.getClassement();
    if (!_rankingStreamController.isClosed) {
      _rankingStreamController.sink.add(classement);
    }
  }

  @override
  void dispose() {
    _rankingStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(top: 25, left: 20, right: 20, bottom: 25),
            child: StreamBuilder(
              stream: _rankingStreamController.stream,
              builder: (context, snapdata) {
                switch (snapdata.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    if (snapdata.hasError) {
                      return Text("Attend frere");
                    } else {
                      return Column(
                        children: createWidget(snapdata.data),
                      );
                    }
                }
              },
            )),
      ),
    );
  }

  createWidget(List<ClassementViewModel> data) {
    var userList = <Widget>[];
    for (int i = 0; i < data.length; i++) {
      var element = data[i];
      var widget = UserClassementWidget(user: element, pos: i + 1);
      userList.add(widget);
      var divider =
          Divider(color: Colors.black, indent: 10, endIndent: 10, thickness: 5);
      userList.add(divider);
    }
    if (userList.isNotEmpty) userList.removeLast();

    return userList;
  }
}
