import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/Model/history.dart';
import 'package:mvvm/View/pages/historique/history_widget.dart';
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
  String dropdownValue = 'Tout';
  String filter = "Tout";
  List<History> copy;
  @override
  initState() {
    super.initState();
    widget.historys.sort((a, b) => b.getDateTime.compareTo(a.getDateTime));
    copy = widget.historys.toList();
  }

  List<Widget> _filterAndTrie() {
    return [
      const Text("Trier: ",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
              case "Tout":
                widget.historys = copy;
                break;
              case "Récent -> Ancienne":
                widget.historys
                    .sort((b, a) => a.getDateTime.compareTo(b.getDateTime));
                break;
              case "Ancienne -> Récente":
                widget.historys
                    .sort((a, b) => a.getDateTime.compareTo(b.getDateTime));
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
          'Tout',
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
      const Text("Filtrer: ",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
              case "Tout":
                widget.historys = copy;
                break;
              case "Achat":
                widget.historys =
                    copy.where((element) => element.type == "ACHAT").toList();
                break;
              case "Vente":
                widget.historys =
                    copy.where((element) => element.type == "VENTE").toList();
                break;
              case "BITCOIN":
                widget.historys =
                    copy.where((element) => element.cryptoId == "BTC").toList();
                break;
              case "ETHERUM":
                widget.historys =
                    copy.where((element) => element.cryptoId == "ETH").toList();
                break;

              default:
            }
          });
        },
        items: <String>['Tout', 'Achat', 'Vente', 'BITCOIN', 'ETHERUM']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
      if (kIsWeb)
        const Tooltip(
          textStyle: TextStyle(fontSize: 16),
          height: 60,
          message:
              "Si vous voulez plus de choix de filtre, par ex: avoir plus de crypto dedans. Contactez depuis notre page de contact",
          child: Icon(Icons.help),
        )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: ViewModelBuilder<HistoryViewModel>.reactive(
        disposeViewModel: false,
        viewModelBuilder: () => HistoryViewModel(),
        builder: (context, model, child) => Wrap(
          spacing: 16,
          runSpacing: 16,
          children: <Widget>[
            kIsWeb
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: _filterAndTrie(),
                  )
                : Center(
                    child: Column(
                      children: _filterAndTrie(),
                    ),
                  ),
            if (widget.historys == null) const LinearProgressIndicator(),
            if (widget.historys != null && widget.historys.isEmpty)
              const Center(
                child: Text("Vous n'avez effectué aucune transaction",
                    style: TextStyle(fontSize: 24)),
              ),
            if (widget.historys != null && widget.historys.isNotEmpty)
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
      ),
    );
  }
}
