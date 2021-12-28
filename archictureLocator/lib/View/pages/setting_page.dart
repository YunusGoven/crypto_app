import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/Services/color_service.dart';
import 'package:mvvm/Services/navigation_service.dart';
import 'package:mvvm/Services/theme_service.dart';
import 'package:mvvm/locator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key key}) : super(key: key);
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool darkmode = false;
  dynamic savedThemeMode;

  Color _selectedPrimaryColor;
  Color _selectedNavbarColor;

  _onBackPressed() {
    locator<NavigationService>().goBack();
  }

  @override
  void initState() {
    super.initState();
    getCurrentTheme();
  }

  Future getCurrentTheme() async {
    savedThemeMode = await AdaptiveTheme.getThemeMode();
    if (savedThemeMode.toString() == 'AdaptiveThemeMode.dark') {
      setState(() {
        darkmode = true;
      });
    } else {
      setState(() {
        darkmode = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return _onBackPressed();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              _onBackPressed();
            },
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 5,
          ),
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('Mode sombre'),
                value: darkmode,
                activeColor: Colors.orange,
                onChanged: (bool value) {
                  if (value == true) {
                    AdaptiveTheme.of(context).setDark();
                    const Icon(Icons.dark_mode);
                  } else {
                    AdaptiveTheme.of(context).setLight();
                    const Icon(Icons.light_mode);
                  }
                  setState(() {
                    darkmode = value;
                  });
                },
                secondary: const Icon(Icons.nightlight_round),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     const Flexible(
              //       child: Text(
              //         'Couleur de fond',
              //         style: TextStyle(
              //           fontSize: 20,
              //         ),
              //       ),
              //     ),
              //     TextButton(
              //       onPressed: () {
              //         showDialog(
              //           context: context,
              //           builder: (BuildContext context) {
              //             return AlertDialog(
              //               actions: <Widget>[
              //                 IconButton(
              //                   onPressed: () {
              //                     Navigator.of(context).pop(true);
              //                   },
              //                   icon: const Icon(Icons.check),
              //                 ),
              //               ],
              //               content: SingleChildScrollView(
              //                 child: SizedBox(
              //                   height:
              //                       MediaQuery.of(context).size.height * 0.35,
              //                   child: MaterialColorPicker(
              //                     circleSize: 50,
              //                     selectedColor:
              //                         Color(colorChanger.getprimary) ??
              //                             Colors.teal[700],
              //                     onColorChange: (Color color) {
              //                       setState(() {
              //                         _selectedPrimaryColor = color;
              //                         colorChanger.changePrimaryColor(
              //                             _selectedPrimaryColor.value);
              //                       });
              //                     },
              //                   ),
              //                 ),
              //               ),
              //             );
              //           },
              //         );
              //       },
              //       child: CircleAvatar(
              //         child: const Icon(
              //           Icons.color_lens,
              //           color: Colors.white54,
              //         ),
              //         backgroundColor:
              //             Color(colorChanger.getprimary) ?? Colors.teal[700],
              //       ),
              //     ),
              //   ],
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     const Flexible(
              //       child: Text(
              //         'Couleur de la barre de navigation',
              //         style: TextStyle(
              //           fontSize: 20,
              //         ),
              //       ),
              //     ),
              //     TextButton(
              //       onPressed: () {
              //         showDialog(
              //           context: context,
              //           builder: (BuildContext context) {
              //             return AlertDialog(
              //               actions: <Widget>[
              //                 IconButton(
              //                   onPressed: () {
              //                     Navigator.of(context).pop(true);
              //                   },
              //                   icon: const Icon(Icons.check),
              //                 ),
              //               ],
              //               content: SingleChildScrollView(
              //                 child: SizedBox(
              //                   height:
              //                       MediaQuery.of(context).size.height * 0.35,
              //                   child: MaterialColorPicker(
              //                     circleSize: 50,
              //                     selectedColor:
              //                         Color(colorChanger.getnavbar) ??
              //                             Colors.amber,
              //                     onColorChange: (Color color) {
              //                       setState(() {
              //                         _selectedNavbarColor = color;
              //                         colorChanger.changeNavbarColor(
              //                             _selectedNavbarColor.value);
              //                       });
              //                     },
              //                   ),
              //                 ),
              //               ),
              //             );
              //           },
              //         );
              //       },
              //       child: CircleAvatar(
              //         child: const Icon(
              //           Icons.color_lens,
              //           color: Colors.white54,
              //         ),
              //         backgroundColor:
              //             Color(colorChanger.getnavbar) ?? Colors.amber,
              //       ),
              //     ),
              // ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
