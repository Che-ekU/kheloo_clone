import 'package:ajay_kumar_flutter_task/video_player.module/provider/video_player_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import 'widgets/overlay_controls.dart';

class CustomVideoPlayer extends StatefulWidget {
  const CustomVideoPlayer({Key? key}) : super(key: key);

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  @override
  void initState() {
    VideoPlayerProvider videoPlayerProvider =
        context.read<VideoPlayerProvider>();
    videoPlayerProvider.videoPlayerController = VideoPlayerController.network(
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4")
      //  videoPlayerProvider.videoPlayerController =  VideoPlayerController.asset("assets/videos/ForBiggerFun.mp4")
      ..addListener(() => videoPlayerProvider.notify())
      ..setLooping(false)
      ..initialize().then(
        (_) {
          // isVideoPlaying.value = true;
          // videoPlayerController.play();
        },
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VideoPlayerProvider>(
        builder: (context, VideoPlayerProvider videoController, child) {
      return DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.black),
        child: SizedBox(
          height: 220,
          child: videoController.videoPlayerController.value.isInitialized
              ? Stack(
                  alignment: Alignment.center,
                  // fit: StackFit.expand,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: videoController
                          .videoPlayerController.value.aspectRatio,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: videoController
                              .videoPlayerController.value.size.width,
                          height: videoController
                              .videoPlayerController.value.size.height,
                          child: VideoPlayer(
                            videoController.videoPlayerController,
                          ),
                        ),
                      ),
                    ),
                    const OverlayControls(isLandscape: false),
                    !videoController.isControlsVisible
                        ? GestureDetector(
                            onTap: () {
                              videoController.toggleControlVisibility();
                            },
                          )
                        : const SizedBox(),
                  ],
                )
              : const Center(child: CircularProgressIndicator()),
        ),
      );
    });
  }
}
