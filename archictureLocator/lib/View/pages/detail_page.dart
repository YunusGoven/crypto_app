import 'package:flutter/material.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/Services/navigation_service.dart';
import 'package:mvvm/Services/userinfo_service.dart';
import 'package:mvvm/View/components/detail_graph_widget.dart';
import 'package:mvvm/View/components/detail_midde_lwidget.dart';
import 'package:mvvm/View/components/detail_up_widget.dart';
import 'package:mvvm/View/widgets/buy_button_widget.dart';
import 'package:mvvm/View/widgets/sell_button_widget.dart';
import 'package:mvvm/ViewModel/crypto_viewmodel.dart';
import 'package:mvvm/locator.dart';
import 'package:stacked/stacked.dart';

class DetailPage extends StatefulWidget {
  final String cryptoId;
  const DetailPage({Key key, @required this.cryptoId}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CryptoViewModel>.reactive(
        viewModelBuilder: () => CryptoViewModel(),
        onModelReady: (model) => model.getCrypto(widget.cryptoId),
        builder: (context, model, child) => SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.only(
                  top: 25, left: 20, right: 20, bottom: 25),
              child: model.crypto == null
                  ? const LinearProgressIndicator()
                  : Column(
                      children: [
                        DetailUp(crypto: model.crypto),
                        const SizedBox(
                          height: 50,
                        ),
                        DetailMiddle(crypto: model.crypto),
                        const SizedBox(
                          height: 50,
                        ),
                        Graph(crypto: model.crypto),
                        const SizedBox(
                          height: 50,
                        ),
                        FutureBuilder<bool>(
                          future: locator<Auth>().isAuthenticate(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data) {
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        FloatingActionButton.extended(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    BuyButtonWidget(
                                                      crypto: model.crypto,
                                                    ));
                                          },
                                          label: const Text("Acheter"),
                                          icon: const Icon(
                                              Icons.add_shopping_cart),
                                        ),
                                        FloatingActionButton.extended(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    SellButtonWidget(
                                                      crypto: model.crypto,
                                                    ));
                                          },
                                          label: const Text("Vendre"),
                                          icon: const Icon(Icons.sell),
                                        ),
                                      ],
                                    ),
                                    FloatingActionButton.extended(
                                      onPressed: () {
                                        locator<NavigationService>().navigateTo(
                                            MessagingRoute,
                                            queryParams: {
                                              'cryptoId': widget.cryptoId
                                            });
                                      },
                                      label: const Text("Discussion"),
                                      icon: const Icon(Icons.message),
                                    ),
                                  ],
                                );
                              }
                            }
                            return Container();
                          },
                        ),
                      ],
                    ),
            )));
  }
}
