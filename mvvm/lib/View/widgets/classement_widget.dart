import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/ViewModel/user_viewmodel.dart';

class UserClassementWidget extends StatefulWidget {
  final RankingViewModel user;
  const UserClassementWidget({Key key, @required this.user}) : super(key: key);

  @override
  _UserClassementWidgetState createState() => _UserClassementWidgetState();
}

class _UserClassementWidgetState extends State<UserClassementWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 30, top: 10, bottom: 10),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.user.pseudo,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "${widget.user.solde} \$",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ]),
      ),
      margin: EdgeInsets.only(bottom: 15),
    );
  }
}
