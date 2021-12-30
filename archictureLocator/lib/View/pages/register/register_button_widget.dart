import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:mvvm/Services/api_service.dart';
import 'package:mvvm/locator.dart';

class RegisterButtonWidget extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController pseudoController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmController;
  final TextEditingController mailController;
  final TextEditingController firstanemContro;
  final TextEditingController surnameContro;
  const RegisterButtonWidget(
      {Key key,
      this.firstanemContro,
      this.formKey,
      this.mailController,
      this.passwordConfirmController,
      this.passwordController,
      this.pseudoController,
      this.surnameContro})
      : super(key: key);

  @override
  _RegisterButtonWidgetState createState() => _RegisterButtonWidgetState();
}

class _RegisterButtonWidgetState extends State<RegisterButtonWidget> {
  var isSend = false;
  final _apiService = locator<ApiService>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        !isSend
            ? ElevatedButton(
                onPressed: () async {
                  if (widget.formKey.currentState.validate()) {
                    setState(() async {
                      isSend = true;
                      var register = await _apiService.register(
                          widget.pseudoController.text,
                          widget.passwordController.text,
                          widget.mailController.text,
                          widget.firstanemContro.text,
                          widget.surnameContro.text);
                      setState(() {
                        isSend = false;
                      });
                      final snackBar = SnackBar(
                        content: Text(
                          register.value,
                          style: const TextStyle(fontSize: 20),
                        ),
                        backgroundColor:
                            register.code == 200 ? Colors.green : Colors.red,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
            var resp = await _apiService.creationGoogle();
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
                backgroundColor: resp.code == 200 ? Colors.green : Colors.red);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
        ),
      ],
    );
  }
}
