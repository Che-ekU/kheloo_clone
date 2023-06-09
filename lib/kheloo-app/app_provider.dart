import 'dart:math';

import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  int presentCarouselIndex = 0;
  List<int> winnersDisplayIndex = [3, 6, 8, 9];
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

  List<bool> expansionStatus = [false,false,false,];

  List<String> gameImages = [
    'https://luckmedia.link/roy_teen_patti/thumb.webp',
    'https://luckmedia.link/tvb_teen_patti/thumb.webp',
    'https://luckmedia.link/pltl_blackjack_7/thumb.webp',
    "https://cdn.hub88.io/spribe/sbe_aviator.png",
    'https://luckmedia.link/pltl_andar_bahar/thumb.webp',
    'https://luckmedia.link/evo_american_roulette/thumb.webp',
  ];
  List<int> getRandomUniqueNumbers() {
    Random random = Random();
    winnersDisplayIndex = [];
    while (winnersDisplayIndex.length < 4) {
      int randomNumber = random.nextInt(10);
      if (!winnersDisplayIndex.contains(randomNumber)) {
        winnersDisplayIndex.add(randomNumber);
      }
    }
    notifyListeners();
    return winnersDisplayIndex;
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
    String? time,
    String? amount,
  })  : time = "${Random().nextInt(10) + 2} seconds ago",
        amount = "${Random().nextInt(9999)}";
  final String name;
  final String? time;
  final String? amount;
}
