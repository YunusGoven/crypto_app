import 'package:flutter/material.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/Services/navigation_service.dart';
import 'package:mvvm/locator.dart';

class WelcomeMessage extends StatelessWidget {
  const WelcomeMessage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 325,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [
              0.1,
              0.3,
              0.5,
              0.7,
              0.9,
            ],
            colors: [
              Colors.yellow,
              Colors.red,
              Colors.amber,
              Colors.indigo,
              Colors.teal,
            ],
          )),
      child: Padding(
        padding: const EdgeInsets.all(36.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Center(
              child: Text(
                "Bienvenue dans la plateforme où vous pouvez vendre ou acheter de la cryptomonnaie en toute sécurité",
                style: TextStyle(color: Colors.white, fontSize: 26),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                    onPressed: () {
                      locator<NavigationService>().navigateTo(RegisterRoute);
                    },
                    style: TextButton.styleFrom(primary: Colors.white),
                    label: const Text("S'Inscrire"),
                    icon: const Icon(Icons.add)),
                TextButton.icon(
                    onPressed: () {
                      locator<NavigationService>().navigateTo(LoginRoute);
                    },
                    style: TextButton.styleFrom(primary: Colors.white),
                    label: const Text("Se Connecter"),
                    icon: const Icon(Icons.login))
              ],
            )
          ],
        ),
      ),
    );
  }
}
