import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvvm/Model/crypto.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Graph extends StatefulWidget {
  final Crypto crypto;
  const Graph({Key key, @required this.crypto}) : super(key: key);

  @override
  _GraphState createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  CrosshairBehavior _crosshairBehavior;
  TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    _crosshairBehavior = CrosshairBehavior(
        enable: true,
        lineDashArray: <double>[5, 5],
        lineWidth: 2,
        activationMode: ActivationMode.singleTap);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<HistoryData> data = getChartData();

    return SfCartesianChart(
      plotAreaBorderWidth: 1,
      plotAreaBorderColor: Colors.grey[700],
      tooltipBehavior: _tooltipBehavior,
      crosshairBehavior: _crosshairBehavior,
      primaryXAxis: DateTimeAxis(
          majorGridLines:
              const MajorGridLines(width: 1, dashArray: <double>[5, 5]),
          title: AxisTitle(text: "Jour"),
          dateFormat: DateFormat("d/M"),
          rangePadding: ChartRangePadding.round),
      primaryYAxis: NumericAxis(
          title: AxisTitle(text: "Valeur \$"),
          decimalPlaces: 4,
          rangePadding: ChartRangePadding.additional),
      series: <ChartSeries>[
        SplineSeries<HistoryData, DateTime>(
            enableTooltip: true,
            dataSource: data,
            xValueMapper: (HistoryData datas, _) =>
                DateTime.tryParse(datas.date),
            yValueMapper: (HistoryData datas, _) => datas.value,
            dataLabelSettings: const DataLabelSettings(isVisible: true)),
      ],
    );
  }

  List<HistoryData> getChartData() {
    List<HistoryData> data = [];
    widget.crypto.HistoryValue.forEach((key, value) {
      var h = HistoryData(key, value);
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
