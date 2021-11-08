import 'package:flutter/material.dart';
import 'package:mvvm/Model/repository/api_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscure = true;
  final pseudoController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    pseudoController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 250,
                  child: Positioned(
                    child: AnimatedOpacity(
                      opacity: 1,
                      duration: Duration(seconds: 1),
                      curve: Curves.linear,
                      child: Image.asset('assets/images/logo.jpg'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                TextField(
                  controller: pseudoController,
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
                  controller: passwordController,
                  obscureText: _obscure,
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
                          _obscure = !_obscure;
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Mot de passe oublié ?',
                          style: TextStyle(color: Colors.black, fontSize: 14.0),
                        ))
                  ],
                ),
                SizedBox(
                  height: 80,
                ),
                Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: MaterialButton(
                        onPressed: () {},
                        child: Image.asset(
                          "assets/logos/google.jpg",
                          height: 45,
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: ElevatedButton(
                        onPressed: () async {
                          await ApiService().connection(
                              pseudoController.text, passwordController.text);
                        },
                        child: Text(
                          'Connexion',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: MaterialButton(
                        onPressed: () {},
                        child: Image.asset(
                          "assets/logos/facebook.jpg",
                          height: 45,
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ],
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
    );
  }
}
