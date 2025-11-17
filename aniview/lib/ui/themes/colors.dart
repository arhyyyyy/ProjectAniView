import 'package:flutter/material.dart';

class AppColors {
  static const Color bluePrimary = Color(0xFF1A73E8);     
  static const Color bluePastel = Color(0xFFE1F0FB);      
  static const Color navy = Color(0xFF0D47A1);           
  static const Color redAccent = Color(0xFFE15757);   
  static const Color softCream = Color(0xFFFFF8F0);
  static const Color softGray = Color(0xFFF4F5F7);
  static const Color sakuraPink = Color(0xFFFFEFF5);
  static const Color lavender = Color(0xFFF3EDFF);
  static const Color white = Colors.white;
  static const Color black = Colors.black87;
  static Gradient mainGradient = const LinearGradient(
    colors: [
      Color(0xFF1A73E8), 
      Color(0xFFE15757),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
