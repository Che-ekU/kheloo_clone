import 'package:ajay_kumar_flutter_task/kheloo-app/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameSection extends StatelessWidget {
  const GameSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 25),
        Container(
          decoration: BoxDecoration(
              color: Colors.amber, borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.symmetric(vertical: 1),
          width: 190,
        ),
        Row(),
        Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Colors.amber, Colors.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ).createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  ),
                  child: const Text(
                    "GAMES",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(20)),
                child: const SizedBox(height: 4, width: 150),
              ),
              for (int i = 0; i < 3; i++) GameCategory(index: i),
            ],
          ),
        ),
      ],
    );
  }
}

class GameCategory extends StatelessWidget {
  const GameCategory({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = context.read<AppProvider>();
    appProvider.gameImages.shuffle();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Column(
        children: [
          const SizedBox(height: 15),
          SizedBox(
            height: 40,
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  width: 6,
                ),
                const SizedBox(width: 15),
                Row(
                  children: [
                    Text(
                      "Game category (${index + 1})",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    appProvider.expansionStatus[index] = true;
                    appProvider.notify();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
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
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Text(
                          "Show More",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            runSpacing: 18,
            children: [
              for (String i in appProvider.gameImages.sublist(0, 4))
                GameCard(i: i),
            ],
          ),
          Consumer(
            builder: (context, AppProvider appProvider, child) =>
                appProvider.expansionStatus[index]
                    ? Column(
                        children: [
                          const SizedBox(height: 18),
                          Wrap(
                            children: [
                              for (String i
                                  in appProvider.gameImages.sublist(4, 6))
                                GameCard(i: i),
                            ],
                          ),
                        ],
                      )
                    : const SizedBox(),
          ),
        ],
      ),
    );
  }
}

class GameCard extends StatelessWidget {
  const GameCard({
    super.key,
    required this.i,
  });

  final String i;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.amber, width: 1.2),
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(image: NetworkImage(i), fit: BoxFit.cover),
      ),
      width: (MediaQuery.of(context).size.width / 2) - 24,
      height: 160,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 1),
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 95, 0, 112),
              borderRadius: BorderRadiusDirectional.vertical(
                bottom: Radius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text.rich(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                  TextSpan(
                    text: "Min",
                    children: [
                      TextSpan(
                        text: " ₹",
                        style: TextStyle(color: Colors.orange),
                      ),
                      TextSpan(
                        text: " ",
                        style: TextStyle(fontSize: 7),
                      ),
                      TextSpan(text: "100"),
                      TextSpan(
                          text: " | ", style: TextStyle(color: Colors.amber)),
                    ],
                  ),
                ),
                Text.rich(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                  TextSpan(
                    text: "Max",
                    children: [
                      TextSpan(
                        text: " ₹",
                        style: TextStyle(color: Colors.orange),
                      ),
                      TextSpan(
                        text: " ",
                        style: TextStyle(fontSize: 7),
                      ),
                      TextSpan(
                        text: "100k",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
