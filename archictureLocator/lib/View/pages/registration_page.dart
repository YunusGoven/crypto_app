import 'package:flutter/material.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/Services/navigation_service.dart';
import 'package:mvvm/locator.dart';

class RegistrationCompletedPage extends StatelessWidget {
  final navigationService = locator<NavigationService>();
  RegistrationCompletedPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            "Votre compte à été confirmée avec succées !",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 60,
          ),
          TextButton(
              onPressed: () async {
                navigationService.navigateTo(LoginRoute);
              },
              child: const Text("Connectez-vous",
                  style: TextStyle(
                    fontSize: 22,
                  ))),
        ],
      ),
    );
  }
}
