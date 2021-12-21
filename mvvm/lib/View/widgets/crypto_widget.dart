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
    var size = MediaQuery.of(context).size.width;
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
                  LogoImage(image: cryptoModel.LogoUrl),
                  SizedBox(
                    width: 60,
                  ),
                  if (size < 380) Text(cryptoModel.Name),
                ],
              ),
              if (size >= 380) Text(cryptoModel.Name),
              Row(
                children: [
                  if (size >= 800)
                    showHistory("30 Jours", cryptoModel.D30Price, cryptoModel),
                  if (size >= 750)
                    showHistory("7 Jours", cryptoModel.D7Price, cryptoModel),
                  if (size >= 700)
                    showHistory("1 Jours", cryptoModel.D1Price, cryptoModel),
                  if (size >= 650)
                    showHistory("1 Heure", cryptoModel.H1Price, cryptoModel),
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

  Widget showHistory(String time, num value, CryptoViewModel cryptoModel) {
    value = cryptoModel.Price + value;
    return Row(
      children: [
        SizedBox(
          width: 40,
        ),
        Column(
          children: [
            Text(
              time,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "${value.toStringAsFixed(4)} \$",
              style: TextStyle(
                color: cryptoModel.Price > value ? Colors.red : Colors.green,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
