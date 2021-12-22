import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/View/widgets/navigation_bar/navigation_bar.dart';
import 'package:mvvm/View/widgets/navigation_bar/navigation_bar_desktop.dart';
import 'package:mvvm/View/widgets/navigation_bar/navigation_bar_mobile.dart';

class ScreenTemplate extends StatefulWidget {
  final Widget child;
  const ScreenTemplate({Key key, this.child}) : super(key: key);

  @override
  _ScreenTemplateState createState() => _ScreenTemplateState();
}

class _ScreenTemplateState extends State<ScreenTemplate> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenwidht = screenSize.width;
    return Scaffold(
        appBar: screenwidht >= 830
            ? null
            : AppBar(
                backgroundColor: Colors.black26,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("CryptoYH")],
                ),
              ),
        drawer: screenwidht >= 830
            ? null
            : Drawer(
                child: ListView(
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.black26,
                      ),
                      child: Text(
                        'HYCrypto',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    NavigationBarMobile()
                  ],
                ),
              ),
        backgroundColor: Colors.white,
        body: kIsWeb
            ? Column(
                children: <Widget>[
                  //if (kIsWeb) const NavigationBar(),
                  if (screenwidht >= 830) NavigationBarTabletDesktop(),
                  Expanded(
                    child: widget.child,
                  )
                ],
              )
            : widget.child);
  }
}





// class ScreenTemplate extends StatelessWidget {
//   final Widget child;
//   const ScreenTemplate({Key key, this.child}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var screenSize = MediaQuery.of(context).size;
//     var screenwidht = screenSize.width;
//     return Scaffold(
//         appBar: screenwidht >= 830
//             ? null
//             : AppBar(
//                 backgroundColor: Colors.black26,
//                 title: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [Text("CryptoYH")],
//                 ),
//               ),
//         drawer: screenwidht >= 830
//             ? null
//             : Drawer(
//                 child: ListView(
//                   children: [
//                     DrawerHeader(
//                       decoration: BoxDecoration(
//                         color: Colors.black26,
//                       ),
//                       child: Text(
//                         'HYCrypto',
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     NavigationBarMobile()
//                   ],
//                 ),
//               ),
//         backgroundColor: Colors.black,
//         body: kIsWeb
//             ? Column(
//                 children: <Widget>[
//                   //if (kIsWeb) const NavigationBar(),
//                   if (screenwidht >= 830) NavigationBarTabletDesktop(),
//                   Expanded(
//                     child: child,
//                   )
//                 ],
//               )
//             : child);
//   }
// }
