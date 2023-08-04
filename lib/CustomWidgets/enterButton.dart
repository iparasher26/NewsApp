import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Constants/constants.dart';

class EnterButton extends StatelessWidget {
  final String? text;
  final VoidCallback function;
  const EnterButton({required this.text,required this.function});

  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    return Container(
      height: 38,
      width: w/2.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppStyle.appBlue,
      ),
      child: InkWell(
        onTap: function,  //doing (){function} puts voidcallback inside voidcallback
        child: Center(
          child: Text(
            text!,
            style:  GoogleFonts.openSans(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
