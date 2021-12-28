import 'package:flutter/material.dart';
import 'package:mvvm/Model/models/history.dart';
import 'package:mvvm/View/widgets/history_widget.dart';
import 'package:mvvm/ViewModel/history_viewmodel.dart';
import 'package:stacked/stacked.dart';

// ignore: must_be_immutable
class HistoryListWidget extends StatefulWidget {
  List<History> historys;
  HistoryListWidget({Key key, this.historys}) : super(key: key);

  @override
  _HistoryListState createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryListWidget> {
  String dropdownValue = 'Aucun';
  String filter = "Aucun";
  List<History> copy;
  @override
  initState() {
    super.initState();
    copy = widget.historys.toList();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HistoryViewModel>.reactive(
      viewModelBuilder: () => HistoryViewModel(),
      builder: (context, model, child) => Wrap(
        spacing: 30,
        runSpacing: 30,
        children: <Widget>[
          const Text("Trier: "),
          DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String newValue) {
              setState(() {
                dropdownValue = newValue;
                switch (dropdownValue) {
                  case "Aucun":
                    widget.historys = copy;
                    break;
                  case "Récent -> Ancienne":
                    widget.historys.sort((b, a) =>
                        DateTime.tryParse(a.dateTransaction)
                            .compareTo(DateTime.tryParse(b.dateTransaction)));
                    break;
                  case "Ancienne -> Récente":
                    widget.historys.sort((a, b) =>
                        DateTime.tryParse(a.dateTransaction)
                            .compareTo(DateTime.tryParse(b.dateTransaction)));
                    break;
                  case "Achat -> Vente":
                    widget.historys.sort((a, b) => a.type.compareTo(b.type));
                    break;
                  case "Vente -> Achat":
                    widget.historys.sort((b, a) => a.type.compareTo(b.type));
                    break;
                  default:
                }
              });
            },
            items: <String>[
              'Aucun',
              'Récent -> Ancienne',
              'Ancienne -> Récente',
              'Achat -> Vente',
              'Vente -> Achat'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          const Text("Filtrer: "),
          DropdownButton<String>(
            value: filter,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String newValue) {
              setState(() {
                filter = newValue;
                switch (filter) {
                  case "Aucun":
                    widget.historys = copy;
                    break;
                  case "Achat":
                    widget.historys = copy
                        .where((element) => element.type == "ACHAT")
                        .toList();
                    break;
                  case "Vente":
                    widget.historys = copy
                        .where((element) => element.type == "VENTE")
                        .toList();
                    break;
                  case "BITCOIN":
                    widget.historys = copy
                        .where((element) => element.cryptoId == "BTC")
                        .toList();
                    break;
                  case "ETHERUM":
                    widget.historys = copy
                        .where((element) => element.cryptoId == "ETH")
                        .toList();
                    break;

                  default:
                }
              });
            },
            items: <String>['Aucun', 'Achat', 'Vente', 'BITCOIN', 'ETHERUM']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          ...widget.historys
              .asMap()
              .map((index, h) => MapEntry(
                    index,
                    HistoryWidget(model: h),
                  ))
              .values
              .toList()
        ],
      ),
    );
  }
}
