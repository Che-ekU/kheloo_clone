import 'package:flutter/material.dart';

import '../home/ui/home.dart';

class KhelooApp extends StatelessWidget {
  const KhelooApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
