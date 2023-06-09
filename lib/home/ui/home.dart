import 'dart:async';
import 'package:ajay_kumar_flutter_task/home/ui/game_section.dart';
import 'package:ajay_kumar_flutter_task/home/ui/jackpot.dart';
import 'package:ajay_kumar_flutter_task/kheloo-app/app_provider.dart';
import 'package:ajay_kumar_flutter_task/video_player.module/provider/video_player_controller.dart';
import 'package:ajay_kumar_flutter_task/video_player.module/ui/video_player_portrait_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<VideoPlayerProvider>().setPortrait();
    // AppProvider appProvider = context.read<AppProvider>();
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
          children: [
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
            const _WinnerContainer(),
            const SizedBox(height: 15),
            const CustomVideoPlayer(),
            const GameSection(),
            const SizedBox(height: 200),
          ],
        ),
      ),
    );
  }
}

class _WinnerContainer extends StatefulWidget {
  const _WinnerContainer();

  @override
  State<_WinnerContainer> createState() => _WinnerContainerState();
}

class _WinnerContainerState extends State<_WinnerContainer> {
  late Timer _timer;

  void startTimer() {
    AppProvider appProvider = context.read<AppProvider>();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (timer.tick % 2 == 0) {
          appProvider.getRandomUniqueNumbers();
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: Colors.amber,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: const LinearGradient(colors: [
            Color.fromARGB(255, 95, 0, 112),
            Color.fromARGB(255, 104, 62, 177),
            Color.fromARGB(255, 95, 0, 112),
          ]),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: Consumer(
            builder: (context, AppProvider appProvider, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WinnerCard(index: appProvider.winnersDisplayIndex[0]),
                      const SizedBox(height: 20),
                      WinnerCard(index: appProvider.winnersDisplayIndex[1]),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WinnerCard(index: appProvider.winnersDisplayIndex[2]),
                      const SizedBox(height: 20),
                      WinnerCard(index: appProvider.winnersDisplayIndex[3]),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class WinnerCard extends StatelessWidget {
  const WinnerCard({
    super.key,
    required this.index,
  });

  final int index;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = context.read<AppProvider>();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.orange),
          child: const CircleAvatar(
            backgroundColor: Color.fromARGB(255, 95, 0, 112),
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              style: const TextStyle(color: Colors.white, fontSize: 16),
              TextSpan(
                text: appProvider.winnerDetails[index].name,
                children: [
                  const TextSpan(
                    text: " ₹",
                    style: TextStyle(color: Colors.orange),
                  ),
                  const TextSpan(
                    text: " ",
                    style: TextStyle(fontSize: 7),
                  ),
                  TextSpan(
                    text: appProvider.winnerDetails[index].amount,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 2),
            Text(
              appProvider.winnerDetails[index].time ?? "",
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 12,
              ),
            )
          ],
        ),
      ],
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
        const Jackpot(),
        const SizedBox(height: 30),
      ],
    );
  }
}
