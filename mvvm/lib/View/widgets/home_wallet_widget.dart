import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvvm/View/pages/detail_page.dart';
import 'package:mvvm/ViewModel/wallet_viewmodel.dart';

class HomeWalletWidget extends StatefulWidget {
  final WalletViewModel walletViewModel;
  const HomeWalletWidget({Key key, this.walletViewModel}) : super(key: key);

  @override
  _HomeWalletWidgetState createState() => _HomeWalletWidgetState();
}

class _HomeWalletWidgetState extends State<HomeWalletWidget> {
  @override
  Widget build(BuildContext context) {
    WalletViewModel walletModel = widget.walletViewModel;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  (DetailPage(cryptoId: walletModel.Cryptoid)),
            ));
      },
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  (walletModel.Imageurl.split(".").last) == "svg"
                      ? SvgPicture.network(
                          walletModel.Imageurl,
                          height: 50,
                          width: 50,
                        )
                      : Image.network(
                          walletModel.Imageurl,
                          height: 50,
                          width: 50,
                        ),
                  Text(walletModel.Name),
                ],
              ),
              Text("${walletModel.Number} ${walletModel.Cryptoid}")
            ],
          ),
        ),
      ),
    );
  }
}
