import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mvvm/View/widgets/classement_widget.dart';
import 'package:mvvm/ViewModel/user_viewmodel.dart';

class ClassementPage extends StatefulWidget {
  const ClassementPage({Key key}) : super(key: key);

  @override
  _ClassementPageState createState() => _ClassementPageState();
}

class _ClassementPageState extends State<ClassementPage> {
  final StreamController<List<ClassementViewModel>> _rankingStreamController =
      StreamController();
  final ClassementViewModel _cvm = ClassementViewModel();

  @override
  void initState() {
    super.initState();
    getRanking();
  }

  getRanking() async {
    List<ClassementViewModel> classement = await _cvm.getClassement();
    _rankingStreamController.sink.add(classement);
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
    data.forEach((element) {
      var widget = UserClassementWidget(user: element);
      userList.add(widget);
      var divider =
          Divider(color: Colors.black, indent: 10, endIndent: 10, thickness: 5);
      userList.add(divider);
    });
    if (userList.isNotEmpty) userList.removeLast();

    //userList.sort((UserClassementWidget a, UserClassementWidget b) => a.user.solde.compareTo(b.user.solde));

    return userList;
  }
}
