import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SociaLogin extends StatelessWidget {
  const SociaLogin({
    Key key,
    @required this.loginSvg
  }) : super(key: key);

  final String loginSvg;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(width: 30,
              height: 30, child: SvgPicture.string(loginSvg)),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
          border: Border.all(width: 1.0, color: const Color(0xff151617)),
        ),
      ),
    );
  }
}
