import 'package:flutter/material.dart';
import 'package:mvvm/Services/api_service.dart';
import 'package:mvvm/locator.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String subject = '';
  String text = '';
  bool isCopy = false;
  bool waiting = false;

  @override
  Widget build(BuildContext context) {
    var sizewidth = MediaQuery.of(context).size.width;
    var taille = sizewidth / 15 * 8;
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Column(
          children: [
            Text(
              'Contact',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 25,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    width: taille,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Nom',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value.length < 3) {
                          return 'Veuillez entrez un nom';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (newValue) => setState(() => name = newValue),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: taille,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        final pattern =
                            r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
                        final regExp = RegExp(pattern);

                        if (value.isEmpty) {
                          return 'Veuillez entrer votre email';
                        } else if (!regExp.hasMatch(value)) {
                          return 'Entrez un email valide';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (value) => setState(() => email = value),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: taille,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Objet',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value.length < 5) {
                          return 'Veuillez entrez un objet';
                        } else {
                          return null;
                        }
                      },
                      maxLength: 25,
                      onSaved: (newValue) => setState(() => subject = newValue),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: taille,
                    child: TextFormField(
                      maxLines: 10,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        labelText: 'Message',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value.length < 20) {
                          return 'Veuillez détailler votre message';
                        } else {
                          return null;
                        }
                      },
                      maxLength: 2500,
                      onSaved: (newValue) => setState(() => text = newValue),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: isCopy,
                        onChanged: (value) {
                          setState(() {
                            isCopy = value;
                          });
                        },
                      ),
                      Text('Recevoir une copie ?')
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  !waiting
                      ? TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.all(4),
                            primary: Colors.white,
                            backgroundColor: Colors.teal,
                            onSurface: Colors.grey,
                          ),
                          child: Text(
                            "Envoyer",
                            style: TextStyle(fontSize: 22),
                          ),
                          onPressed: () async {
                            final isValidate = formKey.currentState.validate();
                            if (isValidate) {
                              setState(() {
                                waiting = !waiting;
                              });
                              formKey.currentState.save();

                              var send = await locator<ApiService>()
                                  .sendMail(name, email, subject, text, isCopy);
                              setState(() {
                                waiting = !waiting;
                              });
                              final message = send.value;
                              final snackBar = SnackBar(
                                content: Text(
                                  message,
                                  style: TextStyle(fontSize: 20),
                                ),
                                backgroundColor: send.code == 200
                                    ? Colors.green
                                    : Colors.red,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                        )
                      : CircularProgressIndicator()
                ],
              ),
            ),
            SizedBox(
              height: 70,
            )
          ],
        ),
      ),
    ));
  }
}
