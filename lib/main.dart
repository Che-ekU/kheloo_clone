import 'package:ajay_kumar_flutter_task/kheloo-app/app_provider.dart';
import 'package:ajay_kumar_flutter_task/kheloo-app/kheloo.dart';
import 'package:ajay_kumar_flutter_task/video_player.module/provider/video_player_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => VideoPlayerProvider()),
      ],
      child: const KhelooApp(),
    ),
  );
}
