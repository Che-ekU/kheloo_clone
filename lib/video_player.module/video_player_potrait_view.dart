import 'package:ajay_kumar_flutter_task/video_player.module/video_player_controller.dart';
import 'package:ajay_kumar_flutter_task/video_player.module/video_player_landscape_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

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
    videoPlayerProvider.videoPlayerController =
        VideoPlayerController.asset("assets/videos/ForBiggerFun.mp4")
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

class OverlayControls extends StatelessWidget {
  const OverlayControls({
    Key? key,
    required this.isLandscape,
  }) : super(key: key);

  final bool isLandscape;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, VideoPlayerProvider videoController, child) =>
          AnimatedSwitcher(
        duration: const Duration(milliseconds: 50),
        reverseDuration: const Duration(milliseconds: 200),
        child: !videoController.isControlsVisible
            ? const SizedBox.shrink()
            : ColoredBox(
                color: Colors.black26,
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        videoController.toggleControlVisibility();
                      },
                    ),
                    isLandscape
                        ? Padding(
                            padding: const EdgeInsets.only(top: 28.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: GestureDetector(
                                      child: const Icon(
                                        Icons.arrow_back,
                                        size: 30,
                                      ),
                                      onTap: () async {
                                        Navigator.pop(context);
                                        await videoController.setPortrait();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox(),
                    VideoPlayerControls(isLandscape: isLandscape),
                  ],
                ),
              ),
      ),
    );
  }
}

class VideoPlayerControls extends StatelessWidget {
  const VideoPlayerControls({
    Key? key,
    required this.isLandscape,
  }) : super(key: key);

  final bool isLandscape;

  @override
  Widget build(BuildContext context) {
    VideoPlayerProvider videoController = context.watch<VideoPlayerProvider>();
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: 5, horizontal: isLandscape ? 35 : 15),
        child: ColoredBox(
          color: Colors.white10,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              VideoProgressIndicator(
                videoController.videoPlayerController,
                padding: EdgeInsets.symmetric(vertical: isLandscape ? 15 : 5),
                colors: const VideoProgressColors(),
                allowScrubbing: true,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(child: SizedBox()),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OverlayControlElement(
                          buttonFunction: () {
                            videoController.seekVideo(-5);
                          },
                          buttonIcon: const Icon(Icons.fast_rewind),
                        ),
                        const SizedBox(width: 10),
                        OverlayControlElement(
                          buttonFunction: () {
                            videoController.pauseVideo();
                          },
                          buttonIcon: Icon(
                            videoController
                                    .videoPlayerController.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                          ),
                        ),
                        const SizedBox(width: 10),
                        OverlayControlElement(
                          buttonFunction: () {
                            videoController.seekVideo(5);
                          },
                          buttonIcon: const Icon(Icons.fast_forward),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: OverlayControlElement(
                        buttonFunction: () async {
                          !isLandscape
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const VideoPlayerLandscapeView()),
                                )
                              : {
                                  Navigator.pop(context),
                                  await videoController.setPortrait(),
                                };
                        },
                        buttonIcon: isLandscape
                            ? const Icon(Icons.minimize)
                            : const Icon(Icons.fullscreen),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: isLandscape ? 15 : 0),
            ],
          ),
        ),
      ),
    );
  }
}

class OverlayControlElement extends StatelessWidget {
  const OverlayControlElement({
    Key? key,
    required this.buttonFunction,
    required this.buttonIcon,
  }) : super(key: key);

  final Function buttonFunction;
  final Widget buttonIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        buttonFunction();
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: buttonIcon,
      ),
    );
  }
}
