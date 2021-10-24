import 'package:flutter/material.dart';
import 'package:hybunsinnes/pages/welcome.dart';

const d_red = Color(0xFFE9717D);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Crypto App',
        debugShowCheckedModeBanner: false,
        home: WelcomePage());
  }
}
