import 'package:flutter/material.dart';
import 'package:hybunsinnes/model/crypto.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailUp extends StatefulWidget {
  final Crypto crypto;
  const DetailUp({Key key, this.crypto}) : super(key: key);

  @override
  _DetailUpState createState() => _DetailUpState();
}

class _DetailUpState extends State<DetailUp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            widget.crypto.name,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.network(
                widget.crypto.image,
                height: 70,
                width: 70,
              ),
              Column(
                children: [
                  Text(
                    "${widget.crypto.currentvalue} \$",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(
                        "${widget.crypto.currentpercent} %",
                        style: TextStyle(
                          color: widget.crypto.currentpercent < 0
                              ? Colors.red
                              : Colors.green,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        widget.crypto.currentpercent < 0
                            ? Icons.arrow_downward_outlined
                            : Icons.arrow_upward_outlined,
                        color: widget.crypto.currentpercent < 0
                            ? Colors.red
                            : Colors.green,
                      )
                    ],
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
