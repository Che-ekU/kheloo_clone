import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  int presentCarouselIndex = 0;
  notify() => notifyListeners();
}

class BottomMenuItemDetails {
  const BottomMenuItemDetails({
    required this.skew,
    required this.icon,
    required this.text,
    this.color,
    this.iconColor,
    this.flex,
  });
  final double skew;
  final IconData icon;
  final String text;
  final Color? color;
  final Color? iconColor;
  final int? flex;
}
