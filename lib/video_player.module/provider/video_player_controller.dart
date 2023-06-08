import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerProvider extends ChangeNotifier {
  late VideoPlayerController videoPlayerController;

  // bool isVideoPlaying = false;
  bool isControlsVisible = true;

  toggleControlVisibility() {
    isControlsVisible = !isControlsVisible;
    notifyListeners();
    // Timer(const Duration(seconds: 1), () {
    //   isControlsVisible.value = false;
    // });
  }

  setLandscape() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    notifyListeners();
  }

  setPortrait() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    notifyListeners();
  }

  pauseVideo() {
    // isControlsVisible = !videoPlayerController.value.isPlaying;
    videoPlayerController.value.isPlaying
        ? videoPlayerController.pause()
        : videoPlayerController.play();
    notifyListeners();
  }

  seekVideo(int rewindOrFastForward) {
    videoPlayerController.seekTo(Duration(
        seconds: videoPlayerController.value.position.inSeconds +
            rewindOrFastForward));
    notifyListeners();
  }

  notify() => notifyListeners();
}
