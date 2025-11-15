import 'package:flutter/material.dart';
import '../themes/colors.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search anime...",
        prefixIcon: Icon(Icons.search, color: AppColors.bluePrimary),
        filled: true,
        fillColor: Colors.white.withValues(alpha: .9),
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
