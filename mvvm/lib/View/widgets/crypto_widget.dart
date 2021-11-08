import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvvm/Model/models/crypto.dart';
import 'package:mvvm/View/pages/detail_page.dart';
import 'package:mvvm/ViewModel/crypto_viewmodel.dart';
import 'package:provider/provider.dart';

class CryptoWidget extends StatefulWidget {
  final CrytoViewModel crypto;
  const CryptoWidget({Key key, @required this.crypto}) : super(key: key);
  @override
  _CryptoWidgetState createState() => _CryptoWidgetState();
}

class _CryptoWidgetState extends State<CryptoWidget> {
  @override
  Widget build(BuildContext context) {
    Crypto cryptoModel = widget.crypto.crypto;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                  create: (context) => CryptoListViewModel(),
                  child: DetailPage(cryptoId: cryptoModel.Id)),
            ));
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
                  (cryptoModel.LogoUrl.split(".").last) == "svg"
                      ? SvgPicture.network(
                          cryptoModel.LogoUrl,
                          height: 50,
                          width: 50,
                        )
                      : Image.network(
                          cryptoModel.LogoUrl,
                          height: 50,
                          width: 50,
                        ),
                ],
              ),
              Column(
                children: [
                  Text("${cryptoModel.Price} \$",
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