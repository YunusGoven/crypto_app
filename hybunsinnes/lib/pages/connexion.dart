import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hybunsinnes/main.dart';
import 'package:hybunsinnes/animations/delayed_animation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hybunsinnes/pages/login.dart';

class ConnexionPage extends StatelessWidget {
  const ConnexionPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          DelayedAnimation(
            delay: 1000,
            child: Container(
              height: 280,
              child: Image.asset("assets/images/welcome.jpg"),
            ),
          ),
          DelayedAnimation(
            delay: 1000,
            child: Container(
              height: 150,
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 30,
                ),
                child: Text(
                  "Connectez-vous",
                  style: GoogleFonts.poppins(
                    color: d_red,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          DelayedAnimation(
            delay: 1200,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 14, horizontal: 40),
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      primary: d_red,
                      padding: EdgeInsets.all(10),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.mail_outline_outlined),
                        SizedBox(width: 10),
                        Text(
                          'EMAIL',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      primary: Color(0xFF576dff),
                      padding: EdgeInsets.all(10),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const FaIcon(FontAwesomeIcons.facebook),
                        SizedBox(width: 10),
                        Text(
                          'Facebook',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      primary: Colors.white,
                      padding: EdgeInsets.all(10),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/logos/google.jpg",
                          height: 20,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Google',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
