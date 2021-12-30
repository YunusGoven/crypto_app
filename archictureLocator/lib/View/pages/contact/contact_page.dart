import 'package:flutter/material.dart';
import 'package:mvvm/Services/api_service.dart';
import 'package:mvvm/View/pages/contact/sending_button.dart';
import 'package:mvvm/View/pages/contact/text_field.dart';
import 'package:mvvm/locator.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController text = TextEditingController();
  bool isCopy = false;

  @override
  Widget build(BuildContext context) {
    var sizewidth = MediaQuery.of(context).size.width;
    var taille = sizewidth / 15 * 8;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Column(
          children: [
            const Text(
              'Contact',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 25,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    width: taille,
                    child: ContactTextField(
                      label: "Nom",
                      controller: nameController,
                      validator: (value) {
                        if (value.length < 3) {
                          return 'Veuillez entrez un nom';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: taille,
                    child: ContactTextField(
                      label: "Email",
                      controller: email,
                      validator: (value) {
                        const pattern =
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
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: taille,
                    child: ContactTextField(
                      label: "Objet",
                      controller: subject,
                      validator: (value) {
                        if (value.length < 5) {
                          return 'Veuillez entrez un objet plus long';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: taille,
                    child: ContactTextField(
                      label: "Message",
                      controller: text,
                      validator: (value) {
                        if (value.length < 20) {
                          return 'Veuillez détailler votre message';
                        } else {
                          return null;
                        }
                      },
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
                      const Text('Recevoir une copie ?')
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ContactSendingButton(
                    email: email,
                    formKey: formKey,
                    isCopy: isCopy,
                    nameController: nameController,
                    subject: subject,
                    text: text,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
