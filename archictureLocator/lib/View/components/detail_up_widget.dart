import 'package:flutter/material.dart';
import 'package:mvvm/Model/models/crypto.dart';
import 'package:mvvm/View/components/image_widget.dart';

class DetailUp extends StatefulWidget {
  final Crypto crypto;
  const DetailUp({Key key, this.crypto}) : super(key: key);

  @override
  _DetailUpState createState() => _DetailUpState();
}

class _DetailUpState extends State<DetailUp> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LogoImage(image: widget.crypto.LogoUrl),
              Text(
                widget.crypto.Name,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              if (size >= 660)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: _cours(),
                )
            ],
          ),
          if (size < 660)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: _cours().reversed.toList(),
            )
        ],
      ),
    );
  }

  List<Widget> _cours() {
    return [
      Text(
        "${widget.crypto.Price.toStringAsFixed(3)} \$",
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      const SizedBox(
        height: 10,
      ),
      SizedBox(
        width: 25,
      ),
      Row(
        children: [
          Text(
            "${widget.crypto.Percent} %",
            style: TextStyle(
              color: widget.crypto.Percent < 0 ? Colors.red : Colors.green,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Icon(
            widget.crypto.Percent < 0
                ? Icons.arrow_downward_outlined
                : Icons.arrow_upward_outlined,
            color: widget.crypto.Percent < 0 ? Colors.red : Colors.green,
          )
        ],
      ),
    ];
  }
}
