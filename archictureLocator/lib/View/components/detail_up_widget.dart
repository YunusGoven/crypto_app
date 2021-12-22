import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvvm/Model/models/crypto.dart';
import 'package:mvvm/View/components/image_widget.dart';
import 'package:mvvm/ViewModel/crypto_viewmodel.dart';

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
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LogoImage(image: widget.crypto.LogoUrl),
              Text(
                widget.crypto.Name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${widget.crypto.Price.toStringAsFixed(3)} \$",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
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