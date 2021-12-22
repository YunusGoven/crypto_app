import 'package:flutter/material.dart';
import 'package:mvvm/Model/models/wallet.dart';
import 'package:mvvm/View/components/image_widget.dart';
import 'package:mvvm/ViewModel/wallet_viewmodel.dart';

class WalletWidget extends StatefulWidget {
  final Wallet model;
  final WalletViewModel walletViewModel;
  const WalletWidget({Key key, this.model, this.walletViewModel})
      : super(key: key);

  @override
  _WalletWidgetState createState() => _WalletWidgetState();
}

class _WalletWidgetState extends State<WalletWidget> {
  @override
  Widget build(BuildContext context) {
    var model = widget.model;
    var walletViewModel = widget.walletViewModel;
    return Container(
      padding: EdgeInsets.only(bottom: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LogoImage(image: model.imageUrl),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    model.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Text("${model.number} ${model.cryptoId}"),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${model.percent} %',
                    style: TextStyle(
                      color: model.percent < 0 ? Colors.red : Colors.green,
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text('${model.gainsPertes} \$',
                      style: TextStyle(
                        color: model.percent < 0 ? Colors.red : Colors.green,
                      )),
                  SizedBox(
                    width: 30,
                  ),
                  Text('${model.gainsPertesTotal} \$')
                ],
              ),
            ],
          ),
          IconButton(
              onPressed: () async {
                if (await walletViewModel.disableNotification(model.cryptoId)) {
                  setState(() {
                    model.nofitication = !model.notificationActivated;
                  });
                }
              },
              icon: model.notificationActivated
                  ? Icon(Icons.notifications)
                  : Icon(Icons.notifications_off))
        ],
      ),
    );
  }
}