import 'package:flutter/material.dart';
import 'package:mvvm/View/components/image_widget.dart';
import 'package:mvvm/ViewModel/wallet_viewmodel.dart';

class WalletWidget extends StatefulWidget {
  final WalletViewModel walletViewModel;
  const WalletWidget({Key key, this.walletViewModel}) : super(key: key);

  @override
  _WalletWidgetState createState() => _WalletWidgetState();
}

class _WalletWidgetState extends State<WalletWidget> {
  @override
  Widget build(BuildContext context) {
    WalletViewModel walletModel = widget.walletViewModel;
    return Container(
      padding: EdgeInsets.only(bottom: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LogoImage(image: walletModel.Imageurl),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    walletModel.Name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Text("${walletModel.Number} ${walletModel.Cryptoid}"),
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
                    '${walletModel.Percent} %',
                    style: TextStyle(
                      color:
                          walletModel.Percent < 0 ? Colors.red : Colors.green,
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text('${walletModel.gainspertes} \$',
                      style: TextStyle(
                        color:
                            walletModel.Percent < 0 ? Colors.red : Colors.green,
                      )),
                  SizedBox(
                    width: 30,
                  ),
                  Text('${walletModel.Total} \$')
                ],
              ),
            ],
          ),
          IconButton(
              onPressed: () async {
                if (await walletModel
                    .disableNotification(walletModel.Cryptoid)) {
                  setState(() {
                    walletModel.NotificationActivated(
                        !walletModel.NoticationActivated);
                  });
                }
              },
              icon: walletModel.NoticationActivated
                  ? Icon(Icons.notifications)
                  : Icon(Icons.notifications_off))
        ],
      ),
    );
  }
}
