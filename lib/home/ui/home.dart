import 'dart:async';

import 'package:ajay_kumar_flutter_task/kheloo-app/app_provider.dart';
import 'package:ajay_kumar_flutter_task/video_player.module/video_player_controller.dart';
import 'package:ajay_kumar_flutter_task/video_player.module/video_player_potrait_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<VideoPlayerProvider>().setPortrait();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leadingWidth: 150,
        toolbarHeight: 60,
        leading: Image.asset("assets/images/kheloo_logo.jpg"),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/gift.jpg",
                height: 30,
              ),
              const Text(
                "Promotions",
                style: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                ),
              )
            ],
          ),
          const SizedBox(width: 5),
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.amber,
                    Colors.amber.withOpacity(0.8),
                  ],
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 22),
                child: Center(
                  child: Text(
                    "LOGIN",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.amber.shade300, Colors.amber.shade700],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        height: 100,
        child: Row(
          children: const [
            _BottomMenuItem(
              details: BottomMenuItemDetails(
                icon: Icons.speaker,
                skew: 0.4,
                iconColor: Colors.white,
                text: "Support",
              ),
            ),
            _BottomMenuItem(
              details: BottomMenuItemDetails(
                icon: Icons.sports_football,
                skew: 0.4,
                color: Colors.black,
                iconColor: Colors.amber,
                text: "Sports",
                flex: 5,
              ),
            ),
            _BottomMenuItem(
              details: BottomMenuItemDetails(
                icon: Icons.monetization_on,
                skew: -0.4,
                color: Colors.black,
                iconColor: Colors.amber,
                text: "Live Casino",
                flex: 5,
              ),
            ),
            _BottomMenuItem(
              details: BottomMenuItemDetails(
                icon: Icons.person,
                skew: -0.4,
                iconColor: Colors.white,
                text: "Register",
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.amber,
        ),
        padding: const EdgeInsets.all(5),
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const _TopSection(),
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Colors.amber, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ).createShader(
                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
              ),
              child: const Text(
                "LIVE WITHDRAWAL",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(12),
              ),
              height: 5,
              width: 200,
            ),
            const SizedBox(height: 10),
            const CustomVideoPlayer(),
            const SizedBox(height: 200),
          ],
        ),
      ),
    );
  }
}

class _BottomMenuItem extends StatelessWidget {
  const _BottomMenuItem({
    required this.details,
  });
  final BottomMenuItemDetails details;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: details.flex ?? 3,
      child: Transform(
        transform: Matrix4.skewX(details.skew),
        child: ColoredBox(
          color: details.color ?? Colors.transparent,
          child: SizedBox(
            height: 100,
            width: double.infinity,
            child: Center(
              child: Transform(
                transform: Matrix4.skewX(-details.skew),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      details.icon,
                      color: details.iconColor,
                      size: 35,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      details.text,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TopSection extends StatelessWidget {
  const _TopSection();

  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider = context.read<AppProvider>();
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              appProvider.presentCarouselIndex = index;
              appProvider.notify();
            },
            autoPlay: true,
            viewportFraction: 1,
            autoPlayInterval: const Duration(seconds: 8),
            aspectRatio: 1 / 0.67,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            pauseAutoPlayOnTouch: true,
            enableInfiniteScroll: true,
          ),
          items: [
            Image.asset("assets/images/carousel 1.png"),
            Image.asset("assets/images/carousel 2.png"),
            Image.asset("assets/images/carousel 3.png"),
            Image.asset("assets/images/carousel 4.png"),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Consumer(
            builder: (context, AppProvider appProvider, child) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 4; i++)
                  Padding(
                    padding: const EdgeInsets.only(left: 6.0),
                    child: ColoredBox(
                      color: appProvider.presentCarouselIndex == i
                          ? Colors.amber
                          : Colors.grey,
                      child: SizedBox(
                        width: 23,
                        height: appProvider.presentCarouselIndex == i ? 3 : 1,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.amber,
                width: 4,
              ),
              bottom: BorderSide(
                color: Colors.amber,
                width: 4,
              ),
            ),
            color: Colors.purple,
          ),
          padding:
              const EdgeInsets.only(bottom: 20, top: 23, right: 40, left: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: ["English", "हिंदी", "తెలుగు", "ಕನ್ನಡ", "தமிழ்", "...."]
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text(
                      e,
                      style: const TextStyle(
                        color: Colors.amber,
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        const SizedBox(height: 80),
        const _Jackpot(),
        const SizedBox(height: 30),
      ],
    );
  }
}

class _Jackpot extends StatefulWidget {
  const _Jackpot();

  @override
  State<_Jackpot> createState() => _JackpotState();
}

class _JackpotState extends State<_Jackpot> {
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
