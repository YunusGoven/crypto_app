import 'package:flutter/material.dart';
import 'package:hybunsinnes/animations/delayed_animation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'connexion.dart';

class HomePage extends StatelessWidget {
  const HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF262525),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 60,
            horizontal: 30,
          ),
          child: Column(
            children: [
              DelayedAnimation(
                  delay: 1500,
                  child: Container(
                    height: 170,
                    child: Image.asset('assets/images/logo.jpg'),
                  )),
              DelayedAnimation(
                  delay: 2000,
                  child: Container(
                    height: 400,
                    child: Image.asset('assets/images/welcome.jpg'),
                  )),
              DelayedAnimation(
                delay: 2500,
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 10,
                    bottom: 20,
                  ),
                  child: Text(
                    'Venez investir vos sous dans notre plateforme! Satisfait ou Rembourser',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              DelayedAnimation(
                  delay: 3000,
                  child: Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: d_red,
                          shape: StadiumBorder(),
                          padding: EdgeInsets.all(10)),
                      child: Text("Get Started"),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ConnexionPage()));
                      },
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
