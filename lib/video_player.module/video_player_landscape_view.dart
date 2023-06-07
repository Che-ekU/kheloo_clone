import 'package:ajay_kumar_flutter_task/video_player.module/video_player_potrait_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'video_player_controller.dart';

class VideoPlayerLandscapeView extends StatefulWidget {
  const VideoPlayerLandscapeView({Key? key}) : super(key: key);

  @override
  State<VideoPlayerLandscapeView> createState() =>
      _VideoPlayerLandscapeViewState();
}

class _VideoPlayerLandscapeViewState extends State<VideoPlayerLandscapeView> {
  @override
  void initState() {
    context.read<VideoPlayerProvider>().setLandscape();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final VideoPlayerProvider videoController =
        context.watch<VideoPlayerProvider>();
    return Scaffold(
      backgroundColor: Colors.black,
      body: WillPopScope(
        onWillPop: () async {
          videoController.setPortrait();
          return true;
        },
        child: Stack(
          alignment: Alignment.center,
          // fit: StackFit.expand,
          children: <Widget>[
            AspectRatio(
              aspectRatio:
                  videoController.videoPlayerController.value.aspectRatio,
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: videoController.videoPlayerController.value.size.width,
                  height:
                      videoController.videoPlayerController.value.size.height,
                  child: VideoPlayer(videoController.videoPlayerController),
                ),
              ),
            ),
            const OverlayControls(isLandscape: true),
            Consumer(
              builder: (context, value, child) =>
                  !videoController.isControlsVisible
                      ? GestureDetector(
                          onTap: () async {
                            await SystemChrome.setEnabledSystemUIMode(
                                SystemUiMode.leanBack);
                            videoController.toggleControlVisibility();
                          },
                        )
                      : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
