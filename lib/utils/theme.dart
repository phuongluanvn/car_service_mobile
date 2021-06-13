import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double defaultMargin = 24;
Color greysoftColor = Color(0xFFF8F8FB);
Color blueColor = Color(0xFF0D0846);
Color yellowColor = Color(0xFFFFAB2E);
Color greyColor = Color(0xFF929292);

String iconsUrl = "assets/icons/";
String imageUrl = "assets/images/";

TextStyle textBlueFont = GoogleFonts.poppins()
    .copyWith(color: blueColor, fontSize: 14, fontWeight: FontWeight.w500);
TextStyle greyTextFont = GoogleFonts.poppins()
    .copyWith(color: greyColor, fontSize: 14, fontWeight: FontWeight.w500);

Container boxStar() {
  return Container(
    margin: EdgeInsets.only(right: 5),
    height: 18,
    width: 18,
    child: Icon(
      Icons.star,
      color: Colors.yellow,
    ),
  );
}
