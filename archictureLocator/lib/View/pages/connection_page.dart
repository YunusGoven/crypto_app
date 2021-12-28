import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/Services/api_service.dart';
import 'package:mvvm/Services/navigation_service.dart';
import 'package:mvvm/locator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _apiService = locator<ApiService>();
  final navigationService = locator<NavigationService>();
  bool _obscure = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController pseudoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    pseudoController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: pseudoController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(0.0),
                  labelText: 'Pseudo',
                  hintText: 'UserName',
                  labelStyle: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                  hintStyle: const TextStyle(
                    fontSize: 14.0,
                  ),
                  prefixIcon: const Icon(
                    Icons.supervised_user_circle,
                    size: 18,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[700], width: 2),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  floatingLabelStyle: const TextStyle(
                    fontSize: 18.0,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[700], width: 1.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                // ignore: missing_return
                validator: (value) {
                  value == null || value.isEmpty
                      ? "Veuillez entrez votre pseudo"
                      : null;
                },
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: passwordController,
                obscureText: _obscure,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(0.0),
                  labelText: 'Password',
                  hintText: 'Password',
                  hintStyle: const TextStyle(
                    fontSize: 14.0,
                  ),
                  labelStyle: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: const Icon(
                    Icons.password,
                    size: 18,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscure = !_obscure;
                      });
                    },
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[700], width: 2),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  floatingLabelStyle: const TextStyle(
                    fontSize: 18.0,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[700], width: 1.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? "Veuillez entrez votre mot de passe"
                    : null,
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      var password = passwordController.value.text;
                      var pseudo = pseudoController.value.text;
                      var login =
                          await _apiService.connection(pseudo, password);
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
              const SizedBox(
                height: 10,
              ),
              SignInButton(
                Buttons.Google,
                text: "Sign up with Google",
                onPressed: () async {
                  var resp = await ApiService().connectiongoogle();
                  if (resp.code == 200) {
                    locator<NavigationService>().navigateTo(HomeRoute);
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
              )
            ],
          )),
    );
  }
}
