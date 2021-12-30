import 'package:flutter/material.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/Services/navigation_service.dart';
import 'package:mvvm/Services/userinfo_service.dart';
import 'package:mvvm/View/pages/connection/connection_button_widget.dart';
import 'package:mvvm/View/pages/connection/text_fiel_widget.dart';
import 'package:mvvm/locator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final navigationService = locator<NavigationService>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController pseudoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    asyncMethod();
  }

  void asyncMethod() async {
    var isCo = await locator<Auth>().isAuthenticate();
    if (isCo) {
      locator<NavigationService>().navigateTo(HomeRoute);
    }
  }

  @override
  void dispose() {
    pseudoController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    size = size >= 700 ? size / 100 * 60 : size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  width: size,
                  child: TextFielConnection(
                      icon: Icons.supervised_user_circle,
                      text: "Pseudo",
                      controller: pseudoController,
                      validator: (value) {
                        return value == null || value.isEmpty
                            ? "Veuillez entrez votre pseudo"
                            : null;
                      }),
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  width: size,
                  child: TextFielConnection(
                    controller: passwordController,
                    icon: Icons.password,
                    text: "Mot de passe",
                    validator: (value) => value == null || value.isEmpty
                        ? "Veuillez entrez votre mot de passe"
                        : null,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ConnectionButtonsWidget(
                    formkey: _formKey,
                    pseudoController: pseudoController,
                    passwordController: passwordController),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Vous n'avez pas encore de compte ? "),
                    TextButton(
                        onPressed: () async {
                          navigationService.navigateTo(RegisterRoute);
                        },
                        child: const Text(
                          "Inscivez-vous",
                        )),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
