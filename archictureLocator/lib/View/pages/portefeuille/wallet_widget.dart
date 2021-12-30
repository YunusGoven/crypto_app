import 'package:flutter/material.dart';
import 'package:mvvm/Model/wallet.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/Services/navigation_service.dart';
import 'package:mvvm/View/pages/portefeuille/wallet_widget_bigsize.dart';
import 'package:mvvm/View/pages/portefeuille/wallet_widget_smallsize.dart';
import 'package:mvvm/View/widgets/image_widget.dart';
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
    var width = MediaQuery.of(context).size.width;
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
      padding: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              child: LogoImage(image: model.imageUrl),
              onTap: () {
                locator<NavigationService>().navigateTo(CryptoDetailsRoute,
                    queryParams: {'cryptoId': model.cryptoId});
              }),
          if (width <= 990)
            WalletSmallSize(
              model: model,
            ),
          if (width > 990)
            WalletBigSize(
              model: model,
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
