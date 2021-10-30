import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CryptoWidget extends StatefulWidget {
  final String imageurl;
  final String name;
  final num currentValue;
  final num percent;
  const CryptoWidget(
      {Key key,
      @required this.name,
      @required this.imageurl,
      @required this.currentValue,
      @required this.percent})
      : super(key: key);
  @override
  _CryptoWidgetState createState() => _CryptoWidgetState();
}

class _CryptoWidgetState extends State<CryptoWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(widget.name),
                  SizedBox(
                    height: 10,
                  ),
                  SvgPicture.network(
                    widget.imageurl,
                    height: 50,
                    width: 50,
                  ),
                ],
              ),
              Column(
                children: [
                  Text("${widget.currentValue} \$",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "${widget.percent} %",
                        style: TextStyle(
                          color: widget.percent < 0 ? Colors.red : Colors.green,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        widget.percent < 0
                            ? Icons.arrow_downward_outlined
                            : Icons.arrow_upward_outlined,
                        color: widget.percent < 0 ? Colors.red : Colors.green,
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
