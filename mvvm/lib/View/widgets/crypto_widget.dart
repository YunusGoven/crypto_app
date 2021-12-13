import 'package:flutter/material.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/Services/navigation_service.dart';
import 'package:mvvm/View/components/image_widget.dart';
import 'package:mvvm/View/pages/detail_page.dart';
import 'package:mvvm/ViewModel/crypto_viewmodel.dart';
import 'package:mvvm/locator.dart';

class CryptoWidget extends StatefulWidget {
  final CryptoViewModel crypto;
  const CryptoWidget({Key key, @required this.crypto}) : super(key: key);
  @override
  _CryptoWidgetState createState() => _CryptoWidgetState();
}

class _CryptoWidgetState extends State<CryptoWidget> {
  @override
  Widget build(BuildContext context) {
    CryptoViewModel cryptoModel = widget.crypto;
    return InkWell(
      onTap: () {
        locator<NavigationService>().navigateTo(CryptoDetailsRoute,
            queryParams: {'cryptoId': cryptoModel.Id});
      },
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(cryptoModel.Name),
                  SizedBox(
                    height: 10,
                  ),
                  LogoImage(image: cryptoModel.LogoUrl),
                ],
              ),
              Column(
                children: [
                  Text("${cryptoModel.Price.toStringAsFixed(4)} \$",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "${cryptoModel.Percent} %",
                        style: TextStyle(
                          color: cryptoModel.Percent < 0
                              ? Colors.red
                              : Colors.green,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        cryptoModel.Percent < 0
                            ? Icons.arrow_downward_outlined
                            : Icons.arrow_upward_outlined,
                        color:
                            cryptoModel.Percent < 0 ? Colors.red : Colors.green,
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
