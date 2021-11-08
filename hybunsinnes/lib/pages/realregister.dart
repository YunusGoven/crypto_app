import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscure1 = true;
  bool _obscure2 = true;
  DateTime _dateTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Inscription",
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0.0),
                      labelText: 'Pseudo',
                      hintText: 'UserName',
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                      ),
                      prefixIcon: Icon(
                        Icons.supervised_user_circle,
                        color: Colors.black,
                        size: 18,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.shade200, width: 2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0.0),
                      labelText: 'Prenom',
                      hintText: 'Prenom',
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                      ),
                      prefixIcon: Icon(
                        Icons.perm_identity,
                        color: Colors.black,
                        size: 18,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.shade200, width: 2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0.0),
                      labelText: 'Nom',
                      hintText: 'Nom',
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                      ),
                      prefixIcon: Icon(
                        Icons.perm_identity_rounded,
                        color: Colors.black,
                        size: 18,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.shade200, width: 2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Text("Date de naissance"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_dateTime == null
                              ? 'dd-mm-yyyy'
                              : DateFormat('dd-MM-yyyy').format(_dateTime)),
                          IconButton(
                            icon: const Icon(
                              Icons.date_range,
                              size: 30,
                            ),
                            onPressed: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime(2000),
                                      firstDate: DateTime(1935),
                                      lastDate: DateTime(2003))
                                  .then((date) {
                                setState(() {
                                  _dateTime = date;
                                });
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0.0),
                      labelText: 'Mail',
                      hintText: 'Mail',
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                      ),
                      prefixIcon: Icon(
                        Icons.mail,
                        color: Colors.black,
                        size: 18,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.shade200, width: 2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    obscureText: _obscure1,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0.0),
                      labelText: 'Password',
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                      ),
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                      prefixIcon: Icon(
                        Icons.password,
                        color: Colors.black,
                        size: 18,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.visibility,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscure1 = !_obscure1;
                          });
                        },
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.shade200, width: 2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    obscureText: _obscure2,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0.0),
                      labelText: 'Validate Password',
                      hintText: 'Validate Password',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                      ),
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                      prefixIcon: Icon(
                        Icons.password,
                        color: Colors.black,
                        size: 18,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.visibility,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscure2 = !_obscure2;
                          });
                        },
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.shade200, width: 2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  MaterialButton(
                    onPressed: () {},
                    height: 45,
                    color: Colors.black,
                    child: Text(
                      'Inscription',
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ],
              )),
        ),
      ],
    ));
  }
}
