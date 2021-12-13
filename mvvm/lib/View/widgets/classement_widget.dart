import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/ViewModel/user_viewmodel.dart';

class UserClassementWidget extends StatefulWidget {
  final ClassementViewModel user;
  final int pos;
  const UserClassementWidget({Key key, @required this.user, @required this.pos})
      : super(key: key);

  @override
  _UserClassementWidgetState createState() => _UserClassementWidgetState();
}

class _UserClassementWidgetState extends State<UserClassementWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Text(
        widget.pos.toString(),
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        width: 10,
      ),
      Expanded(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 30, top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.user.pseudo,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${widget.user.solde} \$",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
