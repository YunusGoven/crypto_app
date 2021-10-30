import 'package:draw_graph/models/feature.dart';
import 'package:flutter/material.dart';
import 'package:hybunsinnes/model/crypto.dart';
import 'package:hybunsinnes/widgets/detailmiddelwidget.dart';
import 'package:hybunsinnes/widgets/detailupwidget.dart';
import 'package:draw_graph/draw_graph.dart';

class DetailPage extends StatefulWidget {
  final Crypto crypto;
  const DetailPage({Key key, @required this.crypto}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 25, left: 20, right: 20, bottom: 25),
          child: Column(
            children: [
              DetailUp(crypto: widget.crypto),
              SizedBox(
                height: 50,
              ),
              DetailMiddle(crypto: widget.crypto),
              SizedBox(
                height: 50,
              ),
              LineGraph(
                features: [
                  Feature(
                    data: [0.1, 4, 5, 3, 4, 8],
                    title: widget.crypto.name,
                    color: Colors.blue,
                  )
                ],
                size: Size(400, 300),
                labelX: ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5', 'Day 6'],
                labelY: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"],
                graphColor: Colors.black,
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton.extended(
                    onPressed: () {},
                    label: Text("Acheter"),
                    icon: Icon(Icons.add_shopping_cart),
                  ),
                  FloatingActionButton.extended(
                    onPressed: () {},
                    label: Text("Discussion"),
                    icon: Icon(Icons.message),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
