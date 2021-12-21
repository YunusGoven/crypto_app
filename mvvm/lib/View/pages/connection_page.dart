import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/Services/api_service.dart';
import 'package:mvvm/Services/navigation_service.dart';
import 'package:mvvm/Services/userinfo_service.dart';
import 'package:mvvm/View/pages/register_page.dart';
import 'package:mvvm/locator.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    verifyIsConnected();
    super.initState();
  }

  verifyIsConnected() async {
    var isAuth = await locator<Auth>().isAuthenticate();
    if (isAuth) {
      dispose();
      locator<NavigationService>().navigateTo(HomeRoute);
    }
  }

  bool _obscure = true;
  final pseudoController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    pseudoController.dispose();
    passwordController.dispose();
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
                // Container(
                //   height: 250,
                //   child: Positioned(
                //     child: AnimatedOpacity(
                //       opacity: 1,
                //       duration: Duration(seconds: 1),
                //       curve: Curves.linear,
                //       child: Image.asset('assets/images/logo.jpg'),
                //     ),
                //   ),
                // ),
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
                      flex: 4,
                      child: ElevatedButton(
                        onPressed: () async {
                          var resp = await ApiService().connection(
                              pseudoController.text, passwordController.text);
                          print(resp.code);
                          if (resp.code == 200) {
                            dispose();
                            locator<NavigationService>().navigateTo(HomeRoute);
                          } else {
                            print(resp.value);
                          }
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
                        onPressed: () async {
                          final FirebaseAuth _auth = FirebaseAuth.instance;
                          final GoogleSignIn _googleSignIn = GoogleSignIn();
                          try {
                            final GoogleSignInAccount googleSignInAccount =
                                await _googleSignIn.signIn();
                            final GoogleSignInAuthentication
                                googleSignInAuthentication =
                                await googleSignInAccount.authentication;
                            final AuthCredential credential =
                                GoogleAuthProvider.credential(
                              accessToken:
                                  googleSignInAuthentication.accessToken,
                              idToken: googleSignInAuthentication.idToken,
                            );
                            await _auth.signInWithCredential(credential);
                            var a = await _auth.currentUser.getIdToken();
                            print(a.toString());
                            var resp = await ApiService().connectiongoogle(a);
                            if (resp.code == 200) {
                              dispose();
                              locator<NavigationService>()
                                  .navigateTo(HomeRoute);
                            } else {
                              print(resp.value);
                            }
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: Text("google"),
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
                  onPressed: () {
                    locator<NavigationService>().navigateTo(RegisterRoute);
                  },
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
