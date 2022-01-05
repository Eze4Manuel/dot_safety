import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

InputDecoration InputDecorationValues ({String hintText = "", IconData prefixIcon = Icons.file_present}) {
  return InputDecoration(
contentPadding: EdgeInsets.fromLTRB(
20.0, 15.0, 20.0, 15.0),
prefixIcon: Icon(
  prefixIcon,
color: AppColors.color12,
),

hintText: hintText,
border: OutlineInputBorder(
borderSide: BorderSide(width: 32.0),
borderRadius:
BorderRadius.circular(6.0)),
focusedBorder: OutlineInputBorder(
borderSide: BorderSide(
color: Colors.white, width: 32.0),
borderRadius:
BorderRadius.circular(6.0)));
}


InputDecoration InputDecorationNoPrefixValues ({String hintText = "", IconData prefixIcon = Icons.file_present}) {
  return InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(
          20.0, 10.0, 20.0, 10.0),

      hintText: hintText,
      hintStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 13,
          fontFamily: 'Montserrat Regular',
          color: AppColors.color10),
      counterText: "",
      border: OutlineInputBorder(
          borderSide: BorderSide(width: 32.0),
          borderRadius:
          BorderRadius.circular(6.0)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.white, width: 32.0),
          borderRadius:
          BorderRadius.circular(6.0)));
}