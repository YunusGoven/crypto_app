import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvvm/Model/models/crypto.dart';

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
            widget.crypto.Name,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (widget.crypto.LogoUrl.split(".").last) == "svg"
                  ? SvgPicture.network(
                      widget.crypto.LogoUrl,
                      height: 50,
                      width: 50,
                    )
                  : Image.network(
                      widget.crypto.LogoUrl,
                      height: 50,
                      width: 50,
                    ),
              Column(
                children: [
                  Text(
                    "${widget.crypto.Price} \$",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(
                        "${widget.crypto.Percent} %",
                        style: TextStyle(
                          color: widget.crypto.Percent < 0
                              ? Colors.red
                              : Colors.green,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        widget.crypto.Percent < 0
                            ? Icons.arrow_downward_outlined
                            : Icons.arrow_upward_outlined,
                        color: widget.crypto.Percent < 0
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
