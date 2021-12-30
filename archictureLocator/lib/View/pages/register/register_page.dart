import 'package:flutter/material.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/Services/navigation_service.dart';
import 'package:mvvm/View/pages/register/register_button_widget.dart';
import 'package:mvvm/View/pages/register/register_textfield.dart';
import 'package:mvvm/locator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final navigationService = locator<NavigationService>();
  final _formKey = GlobalKey<FormState>();
  final _pseudoController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _mailController = TextEditingController();
  final _firstanemContro = TextEditingController();
  final _surnameContro = TextEditingController();
  var _passConfirm = '';

  @override
  void initState() {
    _passwordConfirmController.addListener(() {
      setState(() {
        if (_passwordController.text != _passwordConfirmController.text) {
          _passConfirm = "Les mots de passe ne correspondent pas";
        } else {
          _passConfirm = "";
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _pseudoController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _mailController.dispose();
    _firstanemContro.dispose();
    _surnameContro.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    size = size >= 900 ? size / 100 * 60 : size;
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  "Inscription",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: size,
                  child: TextFieldRegister(
                    controller: _pseudoController,
                    text: "Pseudo",
                    icon: Icons.supervised_user_circle,
                    validator: (value) => value == null ||
                            value.isEmpty ||
                            value.length < 6 ||
                            value.contains(' ')
                        ? "Veuillez entrez un plus long pseudo ou sans espace"
                        : null,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: size,
                  child: TextFieldRegister(
                    controller: _firstanemContro,
                    icon: Icons.perm_identity,
                    text: "Prenom",
                    validator: (value) => value == null ||
                            value.isEmpty ||
                            value.length < 3 ||
                            value.contains(RegExp(r'[0-9]'))
                        ? "Veuillez entrez votre prenom ou enlevez les numeros"
                        : null,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: size,
                  child: TextFieldRegister(
                    controller: _surnameContro,
                    text: "Nom",
                    icon: Icons.perm_identity_rounded,
                    validator: (value) => value == null ||
                            value.isEmpty ||
                            value.length < 4 ||
                            value.contains(RegExp(r'[0-9]'))
                        ? "Veuillez entrez votre nom ou enlevez les numeros"
                        : null,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: size,
                  child: TextFieldRegister(
                    controller: _mailController,
                    text: "Mail",
                    icon: Icons.mail,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Veuillez entrez votre adresse mail";
                      }
                      if (!RegExp(
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                          .hasMatch(value)) {
                        return "Veuillez entre une adresse mail valide !";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: size,
                  child: TextFieldRegister(
                    controller: _passwordController,
                    text: "Mot de passe",
                    icon: Icons.password,
                    validator: (value) => value == null ||
                            value.isEmpty ||
                            value.contains(' ') ||
                            value.length < 6
                        ? "Veuillez entrez un mot de passe sans espace et plus grand que 6 caracteres"
                        : null,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: size,
                  child: TextFieldRegister(
                    controller: _passwordConfirmController,
                    text: "Valider le mot de passe",
                    icon: Icons.password,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.contains(' ') ||
                          value.length < 6) {
                        return "Veuillez entrez un mot de passe sans espace et plus grand que 6 caracteres";
                      }
                      if (_passwordController.text != value) {
                        return "Les mots de passe ne correspondent pas!";
                      }
                      return null;
                    },
                  ),
                ),
                Text(
                  _passConfirm,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(
                  height: 30,
                ),
                RegisterButtonWidget(
                  firstanemContro: _firstanemContro,
                  formKey: _formKey,
                  mailController: _mailController,
                  passwordConfirmController: _passwordConfirmController,
                  passwordController: _passwordController,
                  pseudoController: _pseudoController,
                  surnameContro: _surnameContro,
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Avez vous déjà un compte ? "),
                    TextButton(
                        onPressed: () async {
                          navigationService.navigateTo(LoginRoute);
                        },
                        child: const Text(
                          "Connectez-vous",
                        )),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
