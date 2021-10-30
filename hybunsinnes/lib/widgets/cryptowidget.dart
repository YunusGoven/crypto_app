import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CryptoWidget extends StatelessWidget {
  final String imageurl;
  final String name;
  final num currentValue;
  final num percent;
  const CryptoWidget(
      {Key key, this.name, this.imageurl, this.currentValue, this.percent})
      : super(key: key);

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
                  Text(name),
                  SizedBox(
                    height: 10,
                  ),
                  SvgPicture.network(
                    imageurl,
                    height: 50,
                    width: 50,
                  ),
                ],
              ),
              Column(
                children: [
                  Text("${currentValue} \$",
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
                        "${percent} %",
                        style: TextStyle(
                          color: percent < 0 ? Colors.red : Colors.green,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        percent < 0
                            ? Icons.arrow_downward_outlined
                            : Icons.arrow_upward_outlined,
                        color: percent < 0 ? Colors.red : Colors.green,
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
