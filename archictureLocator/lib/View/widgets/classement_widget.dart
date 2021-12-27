import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/Model/models/user.dart';

class UserClassementWidget extends StatelessWidget {
  final ClassementUser model;
  final int pos;
  const UserClassementWidget(
      {Key key, @required this.model, @required this.pos})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Text(
        pos.toString(),
        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
      const SizedBox(
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
            padding:
                const EdgeInsets.only(left: 10, right: 30, top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  model.pseudo,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${model.solde} \$",
                  style: const TextStyle(
                      fontSize: 19, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
