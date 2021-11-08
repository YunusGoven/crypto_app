import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/View/widgets/detailmiddelwidget.dart';
import 'package:mvvm/View/widgets/detailupwidget.dart';
import 'package:mvvm/ViewModel/crypto_viewmodel.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final String cryptoId;
  const DetailPage({Key key, @required this.cryptoId}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<CryptoListViewModel>(context, listen: false)
        .getCryptos(widget.cryptoId);
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CryptoListViewModel>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 25, left: 20, right: 20, bottom: 25),
          child: Column(
            children: [
              DetailUp(crypto: vm.crypto.crypto),
              SizedBox(
                height: 50,
              ),
              DetailMiddle(crypto: vm.crypto.crypto),
              SizedBox(
                height: 50,
              ),
              LineGraph(
                features: [
                  Feature(
                    data: [0.1, 4, 5, 3, 4, 8],
                    title: vm.crypto.crypto.Name,
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
