import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoImage extends StatelessWidget {
  final String image;
  const LogoImage({Key key, @required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? Image.network(
            image,
            height: 50,
            width: 50,
          )
        : Container(
            child: (image.split(".").last) == "svg"
                ? SvgPicture.network(
                    image,
                    height: 50,
                    width: 50,
                  )
                : Image.network(
                    image,
                    height: 50,
                    width: 50,
                  ));
  }
}
