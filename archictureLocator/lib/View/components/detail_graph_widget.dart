import 'package:flutter/material.dart';
import 'package:mvvm/Model/models/crypto.dart';
import 'package:mvvm/ViewModel/crypto_viewmodel.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Graph extends StatelessWidget {
  final Crypto crypto;
  const Graph({Key key, @required this.crypto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<HistoryData> data = getChartData();

    return SfCartesianChart(
      series: <ChartSeries>[
        LineSeries<HistoryData, dynamic>(
          dataSource: data,
          xValueMapper: (HistoryData datas, _) =>
              DateTime.tryParse(datas.date).hour,
          yValueMapper: (HistoryData datas, _) => datas.value,
          //dataLabelSettings: DataLabelSettings(isVisible: true)
        ),
      ],
    );
  }

  List<HistoryData> getChartData() {
    List<HistoryData> data = [];
    crypto.HistoryValue.forEach((key, value) {
      var h = new HistoryData(key, value);
      data.add(h);
    });
    return data;
  }
}

class HistoryData {
  final String date;
  final double value;
  HistoryData(this.date, this.value);
}
