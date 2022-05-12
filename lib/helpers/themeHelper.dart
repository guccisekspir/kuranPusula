import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeHelper {
  Color backgroundColor = const Color(0XFFE6F2F6);
  Color surfaceColor = const Color(0XFFF1FFFF);
  Color lightSurfaceColor = const Color(0XFFFAFFFF);
  Color primaryColor = const Color(0XFF5ABDA0);
  Color secondaryColor = const Color(0XFFe86253);
  Color onBackgroundDark = const Color(0xFF175154);
  Color onBackgroundLight = const Color(0xFF686D70);
  Color onSurface = Colors.white;
  Color onSurfaceLight = Colors.white54;
  Color onPrimary = Colors.white;
  Color onSecondary = Colors.white;
  Color accentAqua = const Color(0xFF4099ad);
  Color accentBlue = const Color(0xFF12518c);

  BuildContext? ccontext;

  static final ThemeHelper _themeHelper = ThemeHelper._internal();

  ThemeHelper._internal();

  TextStyle get titleTextStyleDark {
    return GoogleFonts.roboto(fontWeight: FontWeight.bold, color: onBackgroundDark);
  }

  TextStyle get titleTextStyleLight {
    return GoogleFonts.roboto(fontWeight: FontWeight.bold, color: backgroundColor);
  }

  TextStyle get subtitleTextStyleDark {
    return GoogleFonts.roboto(fontWeight: FontWeight.normal, color: onBackgroundDark);
  }

  TextStyle get subtitleTextStyleLight {
    return GoogleFonts.roboto(fontWeight: FontWeight.normal, color: backgroundColor);
  }

  factory ThemeHelper({BuildContext? fetchedContext}) {
    //LnadPage'de context'i verdiğimiz için sonraki yerlerde
    //tekrar tekrar çağırmamak için bunu yapıyoruz
    if (fetchedContext != null) {
      _themeHelper.ccontext = fetchedContext;
    }

    return _themeHelper;
  }
}
