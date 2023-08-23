import 'package:flutter/material.dart';

const Color primaryColorLight = Color(0xFFA2E2E2);
const Color primaryColor = Color(0xFF517DE5);
// const Color primaryColor = Color(0xFF2E3192);
const Color primaryColorDark = Color(0xFF2A47D8);
const Color secondaryColorlight = Color(0xFFFFBB54);
const Color secondaryColorDark = Color(0xFFD3661C);
const Color textColorlight = Color(0xFFD8D8D8);
const Color textColor = Color(0xFF7A7A7A);
const Color scaffoldColor = Color(0xFFF6F6F6);
const Color successColor = Color(0xFF1AA231);
const Color badgeColor = Color(0xFFFF4141);

const LinearGradient primaryGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    primaryColorDark,
    primaryColor,
  ],
);