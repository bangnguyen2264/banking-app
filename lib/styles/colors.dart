import 'dart:ui';

import 'package:flutter/material.dart';

class AppColor {
  static const primaryColor_1 = Color(0xFF3629B7);
  static const primaryColor_2 = Color(0xFF3862F8);
  static const accentColor_1 = Color(0xFF469FEF);
  static const accentColor_2 = Color(0xFF5C75F0);
  static const accentColor_3 = Color(0xFF6C56F0);

  static const neutral_1 = Color(0xFFE9EEFF);
  static const neutral_2 = Color(0xFF060F27);
  static const neutral_3 = Color(0xFF91949F);
  static const neutral_4 = Color(0xFFB2B7C7);
  static const neutral_5 = Color(0xFFEBEDF6);
  static const bgColor = LinearGradient(
    colors: [accentColor_1, accentColor_2, accentColor_3],
    stops: [0, 0.26, 0.65], // 0.26, 0.65 
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
