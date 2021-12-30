import 'package:flutter/material.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/Services/navigation_service.dart';
import 'package:mvvm/locator.dart';

class RegistrationCompletedPage extends StatelessWidget {
  final navigationService = locator<NavigationService>();
  final String success;
  RegistrationCompletedPage({Key key, this.success}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isSucces = success == "success";
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            isSucces
                ? "Votre compte à été confirmée avec succées !"
                : "Votre compte n'a pas été confirmé! Une erreur s'est produite",
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 60,
          ),
          isSucces
              ? TextButton(
                  onPressed: () async {
                    navigationService.navigateTo(LoginRoute);
                  },
                  child: const Text("Connectez-vous",
                      style: TextStyle(
                        fontSize: 22,
                      )))
              : Container(),
        ],
      ),
    );
  }
}
