import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hybunsinnes/model/crypto.dart';
import 'package:hybunsinnes/model/wallet.dart';
import '../global.dart' as global;

class TransactionDonePage extends StatefulWidget {
  final Crypto crypto;
  final String type;
  final Wallet wallet;
  const TransactionDonePage(
      {Key key, this.crypto, this.wallet, @required this.type})
      : super(key: key);

  @override
  _TransactionDonePageState createState() => _TransactionDonePageState();
}

class _TransactionDonePageState extends State<TransactionDonePage> {
  num total = 0;
  final myController = TextEditingController();
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 25, left: 20, right: 20, bottom: 25),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.network(
                  widget.crypto.image,
                  height: 50,
                  width: 50,
                ),
                SizedBox(
                  width: 50,
                ),
                Text(widget.crypto.name)
              ],
            ),
            SizedBox(
              height: 50,
            ),
            TextField(
              controller: myController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0.0),
                labelText: 'Nombre',
                hintText: '50000',
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.0,
                ),
                prefixIcon: Icon(
                  Icons.supervised_user_circle,
                  color: Colors.black,
                  size: 18,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                floatingLabelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              keyboardType: TextInputType.number,
              onChanged: (String value) {
                setState(() {
                  try {
                    if (widget.type == "ACHAT") {
                      total = num.parse(myController.text) /
                          widget.crypto.currentvalue;
                    } else {
                      total = num.parse(myController.text) *
                          widget.crypto.currentvalue;
                    }
                  } catch (Exception) {
                    total = 0;
                  }
                });
              },
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "max: ${widget.type == "ACHAT" ? global.user.solde : widget.wallet.number}",
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Text("Valeur Actuelle : ${widget.crypto.currentvalue} \$"),
            SizedBox(
              height: 50,
            ),
            Text("Total: ${total}"),
            SizedBox(
              height: 50,
            ),
            widget.type == "ACHAT"
                ? TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.card_giftcard),
                    label: Text("Acheter"),
                  )
                : TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.card_giftcard),
                    label: Text("Vendre"),
                  )
          ],
        ),
      ),
    );
  }
}
