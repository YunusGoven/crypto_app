import 'package:flutter/material.dart';
import 'package:hybunsinnes/model/user.dart';
import 'package:hybunsinnes/widgets/userclassementwidget.dart';

class ClassementPage extends StatefulWidget {
  final List<User> users;

  const ClassementPage({Key key, @required this.users}) : super(key: key);

  @override
  _ClassementPageState createState() => _ClassementPageState();
}

class _ClassementPageState extends State<ClassementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 25, left: 20, right: 20, bottom: 25),
          child: Column(
            children: createWidget(),
          ),
        ),
      ),
    );
  }

  createWidget() {
    var userWidget = <UserClassementWidget>[];
    widget.users.sort((User b, User a) => a.solde.compareTo(b.solde));
    widget.users.forEach((element) {
      var wi = UserClassementWidget(
        user: element,
      );
      userWidget.add(wi);
    });

    return userWidget;
  }
}
