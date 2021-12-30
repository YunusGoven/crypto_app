import 'package:flutter/material.dart';

class ContactTextField extends StatefulWidget {
  final String Function(String) validator;
  final TextEditingController controller;
  final String label;
  const ContactTextField({Key key, this.label, this.controller, this.validator})
      : super(key: key);

  @override
  _ContactTextFieldState createState() => _ContactTextFieldState();
}

class _ContactTextFieldState extends State<ContactTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.label == "Message" ? 10 : 1,
      keyboardType: widget.label == "Email"
          ? TextInputType.emailAddress
          : TextInputType.text,
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.label,
        border: const OutlineInputBorder(),
      ),
      validator: widget.validator,
    );
  }
}
