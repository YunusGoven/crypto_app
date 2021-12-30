import 'package:flutter/material.dart';
import 'package:mvvm/Services/api_service.dart';
import 'package:mvvm/locator.dart';

class NewCryptoWidget extends StatefulWidget {
  const NewCryptoWidget({Key key}) : super(key: key);

  @override
  _NewCryptoWidgetState createState() => _NewCryptoWidgetState();
}

class _NewCryptoWidgetState extends State<NewCryptoWidget> {
  final textController = TextEditingController();
  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: 120,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[700],
          width: 5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Flexible(
              child: Text(
            "Ajouter nouvelle crypto",
            overflow: TextOverflow.clip,
          )),
          const Tooltip(
            textStyle: TextStyle(fontSize: 16, color: Colors.white),
            height: 60,
            message: "Veuillez vous referer  sur Nomics.com",
            child: Icon(Icons.help),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
              child: TextField(
            controller: textController,
          )),
          const SizedBox(
            width: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              var text = textController.text.toUpperCase();
              var block = await locator<ApiService>().addNewCrypto(text);
              final snackBar = SnackBar(
                content: Text(
                  block.value,
                  style: const TextStyle(fontSize: 20),
                ),
                backgroundColor: block.code == 200 ? Colors.green : Colors.red,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              textController.clear();
            },
            child: const Text("Ajout"),
          )
        ],
      ),
    );
  }
}
