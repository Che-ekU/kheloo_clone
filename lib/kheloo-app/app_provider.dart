import 'dart:math';

import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  int presentCarouselIndex = 0;
  List<int> winnersDisplayIndex = [];
  List<WinnerDetails> winnerDetails = [
    WinnerDetails(name: "Ajay"),
    WinnerDetails(name: "Mega"),
    WinnerDetails(name: "Sachin"),
    WinnerDetails(name: "Aathi"),
    WinnerDetails(name: "Maha"),
    WinnerDetails(name: "Vinay"),
    WinnerDetails(name: "Yoga"),
    WinnerDetails(name: "Pradeep"),
    WinnerDetails(name: "Dhana"),
    WinnerDetails(name: "Thilo"),
  ];
  List<int> getRandomUniqueNumbers() {
    Random random = Random();
    List<int> numbers = [];

    while (numbers.length < 4) {
      int randomNumber = random.nextInt(10);
      if (!numbers.contains(randomNumber)) {
        numbers.add(randomNumber);
      }
    }

    print(numbers);
    winnersDisplayIndex = numbers;
    return numbers;
  }

  notify() => notifyListeners();
}

class BottomMenuItemDetails {
  BottomMenuItemDetails({
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

class WinnerDetails {
  WinnerDetails({
    required this.name,
    this.time,
    this.amount,
  });
  final String name;
  String? time = "${Random().nextInt(10) + 2} seconds ago";
  String? amount = "${Random().nextInt(9999)}";
}
