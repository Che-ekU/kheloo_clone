import 'dart:async';

import 'package:flutter/material.dart';

class Jackpot extends StatefulWidget {
  const Jackpot({super.key});

  @override
  State<Jackpot> createState() => JackpotState();
}

class JackpotState extends State<Jackpot> {
  late Timer _timer;
  final ValueNotifier<int> jackpotAmount = ValueNotifier<int>(92542627);

  List<String> jackpotAmountString = [];

  void startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (jackpotAmount.value == 99999999) {
          jackpotAmount.value = 99999900;
        } else {
          jackpotAmount.value++;
        }
        jackpotAmountString = jackpotAmount.value.toString().split("");
        setState(() {});
      },
    );
  }

  @override
  void initState() {
    jackpotAmountString = jackpotAmount.value.toString().split("");
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: const Alignment(0.01, 0.30),
      children: [
        Image.asset(
          "assets/images/jackpot.png",
          width: 320,
        ),
        Container(
          decoration: const BoxDecoration(color: Colors.amberAccent),
          height: 67,
          width: 270,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < (["₹"] + jackpotAmountString).length; i++)
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 1),
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.amber.withOpacity(0.8),
                            Colors.amber,
                          ],
                        ),
                        border: const Border(
                          bottom: BorderSide(color: Colors.black, width: 1.5),
                          right: BorderSide(color: Colors.black, width: 1.5),
                          left: BorderSide(color: Colors.black, width: 1.5),
                        ),
                      ),
                      child: Text(
                        i == 0 ? "₹" : jackpotAmountString[i - 1],
                        style: const TextStyle(
                          color: Color.fromARGB(255, 210, 14, 0),
                          fontWeight: FontWeight.w800,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    if (i != jackpotAmountString.length)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1),
                        child: Container(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
