import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/Services/api_service.dart';
import 'package:mvvm/Services/navigation_service.dart';
import 'package:mvvm/locator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscure1 = true;
  bool _obscure2 = true;
  final _formKey = GlobalKey<FormState>();
  final _apiService = locator<ApiService>();
  final navigationService = locator<NavigationService>();
  final _pseudoController = TextEditingController();
  final _passwordController = TextEditingController();
  final _mailController = TextEditingController();
  final _firstanemContro = TextEditingController();
  final _surnameContro = TextEditingController();
  var _passConfirm = '';
  var isSend = false;
  @override
  void dispose() {
    _pseudoController.dispose();
    _passwordController.dispose();
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
                  child: TextFormField(
                    controller: _pseudoController,
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
                        borderSide:
                            BorderSide(color: Colors.grey[700], width: 2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      floatingLabelStyle: const TextStyle(
                        fontSize: 18.0,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey[700], width: 1.5),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
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
                  child: TextFormField(
                    controller: _firstanemContro,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(0.0),
                      labelText: 'Prenom',
                      hintText: 'Prenom',
                      labelStyle: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                      hintStyle: const TextStyle(
                        fontSize: 14.0,
                      ),
                      prefixIcon: const Icon(
                        Icons.perm_identity,
                        size: 18,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey[700], width: 2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      floatingLabelStyle: const TextStyle(
                        fontSize: 18.0,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey[700], width: 1.5),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (value) => value == null ||
                            value.isEmpty ||
                            value.length < 3 ||
                            value.contains(RegExp(r'[0-9]'))
                        ? "Veuillez entrez votre prenom ou enlevez les numero"
                        : null,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: size,
                  child: TextFormField(
                    controller: _surnameContro,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(0.0),
                      labelText: 'Nom',
                      hintText: 'Nom',
                      labelStyle: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                      hintStyle: const TextStyle(
                        fontSize: 14.0,
                      ),
                      prefixIcon: const Icon(
                        Icons.perm_identity_rounded,
                        size: 18,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey[700], width: 2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      floatingLabelStyle: const TextStyle(
                        fontSize: 18.0,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey[700], width: 1.5),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (value) => value == null ||
                            value.isEmpty ||
                            value.length < 4 ||
                            value.contains(RegExp(r'[0-9]'))
                        ? "Veuillez entrez votre prenom ou enlevez les numero"
                        : null,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: size,
                  child: TextFormField(
                    controller: _mailController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(0.0),
                      labelText: 'Mail',
                      hintText: 'Mail',
                      labelStyle: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                      hintStyle: const TextStyle(
                        fontSize: 14.0,
                      ),
                      prefixIcon: const Icon(
                        Icons.mail,
                        size: 18,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey[700], width: 2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      floatingLabelStyle: const TextStyle(
                        fontSize: 18.0,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey[700], width: 1.5),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
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
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: _obscure1,
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
                            _obscure1 = !_obscure1;
                          });
                        },
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey[700], width: 2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      floatingLabelStyle: const TextStyle(
                        fontSize: 18.0,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey[700], width: 1.5),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (value) => value == null ||
                            value.isEmpty ||
                            value.contains(' ') ||
                            value.length < 6
                        ? "Veuillez entrez un mot de passe sans espace et plus grand que 6 caractere"
                        : null,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: size,
                  child: TextFormField(
                      obscureText: _obscure2,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(0.0),
                        labelText: 'Validate Password',
                        hintText: 'Validate Password',
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
                              _obscure2 = !_obscure2;
                            });
                          },
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[700], width: 2),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        floatingLabelStyle: const TextStyle(
                          fontSize: 18.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[700], width: 1.5),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.contains(' ') ||
                            value.length < 6) {
                          return "Veuillez entrez un mot de passe sans espace et plus grand que 6 caractere";
                        }
                        if (_passwordController.text != value) {
                          return "Les mots de passe ne correspondent pas!";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          if (_passwordController.text != value) {
                            _passConfirm =
                                "Les mots de passe ne correspontent pas";
                          } else {
                            _passConfirm = "";
                          }
                        });
                      }),
                ),
                Text(
                  _passConfirm,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(
                  height: 30,
                ),
                !isSend
                    ? ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() async {
                              isSend = true;
                              var register = await _apiService.register(
                                  _pseudoController.text,
                                  _passwordController.text,
                                  _mailController.text,
                                  _firstanemContro.text,
                                  _surnameContro.text);
                              setState(() {
                                isSend = false;
                              });
                              final snackBar = SnackBar(
                                content: Text(
                                  register.value,
                                  style: const TextStyle(fontSize: 20),
                                ),
                                backgroundColor: register.code == 200
                                    ? Colors.green
                                    : Colors.red,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            });
                          }
                        },
                        child: const Text(
                          'Inscription',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      )
                    : const CircularProgressIndicator(),
                const SizedBox(
                  height: 20,
                ),
                SignInButton(
                  Buttons.Google,
                  text: "Création avec Google",
                  onPressed: () async {
                    var resp = await ApiService().creationGoogle();
                    var msg = "";
                    if (resp.code == 200) {
                      msg = "votre compte a été créer";
                    } else {
                      msg = resp.value;
                    }
                    final snackBar = SnackBar(
                        content: Text(
                          msg,
                          style: const TextStyle(fontSize: 20),
                        ),
                        backgroundColor:
                            resp.code == 200 ? Colors.green : Colors.red);
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Vous avez déjà un compte ? "),
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
