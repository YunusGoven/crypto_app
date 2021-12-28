import 'package:flutter/material.dart';
import 'package:mvvm/Model/models/wallet.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/Services/navigation_service.dart';
import 'package:mvvm/View/components/image_widget.dart';
import 'package:mvvm/ViewModel/wallet_viewmodel.dart';
import 'package:mvvm/locator.dart';

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
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[700],
          width: 5,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.only(bottom: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              child: LogoImage(image: model.imageUrl),
              onTap: () {
                locator<NavigationService>().navigateTo(CryptoDetailsRoute,
                    queryParams: {'cryptoId': model.cryptoId});
              }),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    model.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Text("${model.number} ${model.cryptoId}"),
                ],
              ),
              const SizedBox(
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
                  const SizedBox(
                    width: 30,
                  ),
                  Text('${model.gainsPertes} \$',
                      style: TextStyle(
                        color: model.percent < 0 ? Colors.red : Colors.green,
                      )),
                  const SizedBox(
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
                  ? const Icon(Icons.notifications)
                  : const Icon(Icons.notifications_off))
        ],
      ),
    );
  }
}
