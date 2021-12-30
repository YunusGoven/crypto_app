import 'package:flutter/material.dart';

class TextFielConnection extends StatefulWidget {
  final String text;
  final TextEditingController controller;
  final String Function(String) validator;
  final IconData icon;
  const TextFielConnection(
      {Key key, this.controller, this.validator, this.text, this.icon})
      : super(key: key);

  @override
  _TextFielConnectionState createState() => _TextFielConnectionState();
}

class _TextFielConnectionState extends State<TextFielConnection> {
  bool _obscure;
  @override
  void initState() {
    _obscure = widget.text == "Password";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscure,
      controller: widget.controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(0.0),
        labelText: widget.text,
        hintText: widget.text,
        labelStyle: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
        ),
        hintStyle: const TextStyle(
          fontSize: 14.0,
        ),
        prefixIcon: Icon(
          widget.icon,
          size: 18,
        ),
        suffixIcon: widget.text == "Password"
            ? IconButton(
                icon: const Icon(
                  Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscure = !_obscure;
                  });
                },
              )
            : null,
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
      validator: widget.validator,
    );
  }
}
