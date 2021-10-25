import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hybunsinnes/animations/delayed_animation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hybunsinnes/constant.dart';
import 'package:hybunsinnes/locator.dart';
import 'package:hybunsinnes/routing/route_names.dart';
import 'package:hybunsinnes/services/navigation_service.dart';

class ConnexionPage extends StatelessWidget {
  const ConnexionPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          DelayedAnimation(
            delay: 1000,
            child: SizedBox(
              height: 280,
              child: Image.asset("assets/images/welcome.jpg"),
            ),
          ),
          DelayedAnimation(
            delay: 1000,
            child: SizedBox(
              height: 150,
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 30,
                ),
                child: Text(
                  "Connectez-vous",
                  style: GoogleFonts.poppins(
                    color: secondaryColor,
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
              margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      primary: secondaryColor,
                      padding: const EdgeInsets.all(10),
                    ),
                    onPressed: () {
                      locator<NavigationService>().navigateTo(LoginRoute);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.mail_outline_outlined),
                        const SizedBox(width: 10),
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
                  const SizedBox(width: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      primary: primaryColor,
                      padding: const EdgeInsets.all(10),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const FaIcon(FontAwesomeIcons.facebook),
                        const SizedBox(width: 10),
                        Text(
                          'Facebook',
                          style: GoogleFonts.poppins(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      primary: Colors.white,
                      padding: const EdgeInsets.all(10),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/logos/google.jpg",
                          height: 20,
                        ),
                        const SizedBox(width: 10),
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
