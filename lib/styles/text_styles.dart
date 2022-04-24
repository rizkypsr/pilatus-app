import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pilatusapp/styles/colors.dart';

final TextStyle kHeading5 = GoogleFonts.poppins(
    fontSize: 23, fontWeight: FontWeight.normal, color: kLightOnSurfaceVariant);
final TextStyle kHeading6 = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    color: kLightOnSurfaceVariant);
final TextStyle kSubtitle = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
    color: kLightOnSurfaceVariant);
final TextStyle kSubtitle2 = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
    color: kLightOnSurfaceVariant);
final TextStyle kBodyText = GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: kLightOnSurfaceVariant);

final kTextTheme = TextTheme(
  headline5: kHeading5,
  headline6: kHeading6,
  subtitle1: kSubtitle,
  bodyText2: kBodyText,
);
