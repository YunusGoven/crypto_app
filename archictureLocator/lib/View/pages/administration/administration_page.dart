import 'package:flutter/material.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/Services/api_service.dart';
import 'package:mvvm/Services/navigation_service.dart';
import 'package:mvvm/View/pages/administration/new_crypto_widget.dart';
import 'package:mvvm/View/pages/administration/user_list_widget.dart';
import 'package:mvvm/locator.dart';

class AdministrationPage extends StatefulWidget {
  const AdministrationPage({Key key}) : super(key: key);

  @override
  _AdministrationPageState createState() => _AdministrationPageState();
}

class _AdministrationPageState extends State<AdministrationPage> {
  @override
  Widget build(BuildContext context) {
    var mWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Administration",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              const NewCryptoWidget(),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Utilisateurs",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        locator<NavigationService>().navigateTo(RegisterRoute);
                      },
                      icon: const Icon(Icons.add),
                      label: const Text("Ajouter utilisateur")),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                width: mWidth,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey[700],
                    width: 5,
                  ),
                ),
                child: const UserListWidget(),
              ),
            ],
          )),
    );
  }
}
