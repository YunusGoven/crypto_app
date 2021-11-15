import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvvm/Model/repository/api_services.dart';
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.network(
            walletModel.Imageurl,
            height: 50,
            width: 50,
          ),
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    walletModel.Name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                      "${walletModel.Number.toStringAsFixed(8)} ${walletModel.Cryptoid}"),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${walletModel.Percent} %',
                    style: TextStyle(
                      color:
                          walletModel.Percent < 0 ? Colors.red : Colors.green,
                    ),
                  ),
                  Text('${walletModel.gainspertes} \$',
                      style: TextStyle(
                        color:
                            walletModel.Percent < 0 ? Colors.red : Colors.green,
                      )),
                  Text('${walletModel.Total} \$')
                ],
              ),
            ],
          ),
          IconButton(
              onPressed: () async {
                if (await ApiService()
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
