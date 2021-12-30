import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/Services/api_service.dart';
import 'package:mvvm/Services/navigation_service.dart';
import 'package:mvvm/locator.dart';

class ConnectionButtonsWidget extends StatelessWidget {
  final GlobalKey<FormState> formkey;
  final TextEditingController passwordController;
  final TextEditingController pseudoController;
  ConnectionButtonsWidget(
      {Key key, this.formkey, this.passwordController, this.pseudoController})
      : super(key: key);

  final _apiService = locator<ApiService>();
  final navigationService = locator<NavigationService>();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SignInButton(
          Buttons.Google,
          text: "Connection avec Google",
          onPressed: () async {
            var resp = await _apiService.connectiongoogle();
            if (resp.code == 200) {
              navigationService.navigateTo(HomeRoute);
            } else {
              final snackBar = SnackBar(
                content: Text(
                  resp.value,
                  style: const TextStyle(fontSize: 20),
                ),
                backgroundColor: Colors.red,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
        ),
        ElevatedButton(
            onPressed: () async {
              if (formkey.currentState.validate()) {
                var password = passwordController.value.text;
                var pseudo = pseudoController.value.text;
                var login = await _apiService.connection(pseudo, password);
                if (login.code == 200) {
                  navigationService.navigateTo(HomeRoute);
                } else {
                  final snackBar = SnackBar(
                    content: Text(
                      login.value,
                      style: const TextStyle(fontSize: 20),
                    ),
                    backgroundColor: Colors.red,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              }
            },
            child: const Text(
              "Connection",
            )),
      ],
    );
  }
}
