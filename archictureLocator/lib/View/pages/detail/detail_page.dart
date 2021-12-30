import 'package:flutter/material.dart';
import 'package:mvvm/Model/user.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/Services/navigation_service.dart';
import 'package:mvvm/View/pages/detail/calculator_widget.dart';
import 'package:mvvm/View/pages/detail/detail_graph_widget.dart';
import 'package:mvvm/View/pages/detail/detail_midde_lwidget.dart';
import 'package:mvvm/View/pages/detail/detail_up_widget.dart';
import 'package:mvvm/View/pages/detail/transaction_button_widget.dart';
import 'package:mvvm/ViewModel/crypto_viewmodel.dart';
import 'package:mvvm/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';

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
    final user = Provider.of<User>(context);
    return Scaffold(
      floatingActionButton: user != null
          ? FloatingActionButton(
              tooltip: 'Discussion',
              hoverColor: Colors.orange,
              hoverElevation: 50,
              elevation: 12,
              onPressed: () {
                locator<NavigationService>().navigateTo(MessagingRoute,
                    queryParams: {'cryptoId': widget.cryptoId});
              },
              child: const Icon(Icons.message),
            )
          : null,
      body: ViewModelBuilder<CryptoViewModel>.reactive(
        viewModelBuilder: () => CryptoViewModel(),
        onModelReady: (model) => model.getCrypto(widget.cryptoId),
        disposeViewModel: false,
        builder: (context, model, child) => SingleChildScrollView(
            child: Padding(
          padding:
              const EdgeInsets.only(top: 25, left: 20, right: 20, bottom: 25),
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Converter",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        CalculatorWidget(cryptoValue: model.crypto),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Graph(crypto: model.crypto),
                    const SizedBox(
                      height: 50,
                    ),
                    TransactionButtonWidget(
                      crypto: model.crypto,
                    )
                  ],
                ),
        )),
      ),
    );
  }
}
