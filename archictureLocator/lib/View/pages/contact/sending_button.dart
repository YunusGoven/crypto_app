import 'package:flutter/material.dart';
import 'package:mvvm/Services/api_service.dart';
import 'package:mvvm/locator.dart';

class ContactSendingButton extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController email;
  final TextEditingController subject;
  final TextEditingController text;
  final bool isCopy;
  const ContactSendingButton(
      {Key key,
      this.isCopy,
      this.formKey,
      this.email,
      this.nameController,
      this.subject,
      this.text})
      : super(key: key);

  @override
  _ContactSendingButtonState createState() => _ContactSendingButtonState();
}

class _ContactSendingButtonState extends State<ContactSendingButton> {
  bool waiting = false;
  final _apiService = locator<ApiService>();

  @override
  Widget build(BuildContext context) {
    return !waiting
        ? TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(4),
              primary: Colors.white,
              backgroundColor: Colors.teal,
              onSurface: Colors.grey,
            ),
            child: const Text(
              "Envoyer",
              style: TextStyle(fontSize: 22),
            ),
            onPressed: () async {
              final isValidate = widget.formKey.currentState.validate();
              if (isValidate) {
                setState(() {
                  waiting = !waiting;
                });
                widget.formKey.currentState.save();

                var send = await _apiService.sendMail(
                    widget.nameController.text,
                    widget.email.text,
                    widget.subject.text,
                    widget.text.text,
                    widget.isCopy);
                setState(() {
                  waiting = !waiting;
                });
                final message = send.value;
                final snackBar = SnackBar(
                  content: Text(
                    message,
                    style: const TextStyle(fontSize: 20),
                  ),
                  backgroundColor: send.code == 200 ? Colors.green : Colors.red,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
          )
        : const CircularProgressIndicator();
  }
}
