import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';
import 'package:wedding/constants/app_colors.dart';

import '../constants/app_assets.dart';

class InvitationView extends StatefulWidget {
  const InvitationView({
    super.key,
    required this.controller,
    required this.onTapRegister,
    required this.shouldPlay,
  });

  final VideoPlayerController controller;
  final VoidCallback onTapRegister;

  // Chỉ bắt đầu thử play hero sau khi intro kết thúc.
  final bool shouldPlay;

  @override
  State<InvitationView> createState() => _InvitationViewState();
}

class _InvitationViewState extends State<InvitationView>
    with SingleTickerProviderStateMixin {
  late AnimationController _arrowAnimationController;

  bool _videoStarted = false;
  bool _playAttempted = false;

  @override
  void initState() {
    super.initState();

    _arrowAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    widget.controller.addListener(_videoListener);

    _maybePlayVideo();
  }

  @override
  void didUpdateWidget(covariant InvitationView oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Intro vừa kết thúc.
    if (!oldWidget.shouldPlay && widget.shouldPlay) {
      _maybePlayVideo();
    }
  }

  void _videoListener() {
    if (!mounted) return;

    final value = widget.controller.value;

    // Nếu video lỗi trong lúc đang chạy,
    // quay trở lại ảnh fallback.
    if (value.hasError) {
      if (_videoStarted) {
        setState(() {
          _videoStarted = false;
        });
      }

      return;
    }

    // Nếu controller vừa initialize xong
    // và intro cũng đã kết thúc thì thử play.
    if (widget.shouldPlay &&
        value.isInitialized &&
        !_playAttempted) {
      _tryPlayVideo();
    }

    // Chỉ hiện video khi nó thực sự chạy
    // và đã có frame.
    if (!_videoStarted &&
        value.isInitialized &&
        value.isPlaying &&
        value.position > Duration.zero) {
      setState(() {
        _videoStarted = true;
      });
    }
  }

  void _maybePlayVideo() {
    if (!widget.shouldPlay) return;

    if (!widget.controller.value.isInitialized) {
      // Chưa init xong.
      // Listener sẽ tự gọi _tryPlayVideo khi init xong.
      return;
    }

    if (_playAttempted) return;

    _tryPlayVideo();
  }

  Future<void> _tryPlayVideo() async {
    if (_playAttempted) return;

    _playAttempted = true;

    try {
      await widget.controller.setLooping(true);

      // Hero là background video nên mute.
      // iOS cũng dễ cho autoplay muted hơn.
      await widget.controller.setVolume(0);

      await widget.controller.play();
    } catch (e) {
      debugPrint(
        'Hero video play failed. Using static image: $e',
      );

      // Không làm gì cả.
      // _videoStarted = false
      // => thumbnail tiếp tục hiển thị.
    }
  }

  @override
  Widget build(BuildContext context) {
    final initialized =
        widget.controller.value.isInitialized;

    final videoSize = widget.controller.value.size;

    return SizedBox(
      width: double.infinity,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              // =================================================
              // STATIC FALLBACK
              //
              // LUÔN render ảnh này.
              // =================================================
              Image.asset(
                AppAssets.introLandingThumb,
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),

              // =================================================
              // VIDEO
              //
              // Chỉ render đè lên ảnh khi video đã chạy thật.
              // =================================================
              if (initialized && _videoStarted)
                Positioned.fill(
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: SizedBox(
                      width: videoSize.width,
                      height: videoSize.height,
                      child: VideoPlayer(
                        widget.controller,
                      ),
                    ),
                  ),
                ),

              // =================================================
              // TEXT / CONTENT
              // =================================================
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: initialized
                        ? videoSize.height * 0.02
                        : 20,
                    bottom: 40,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "NGÀY CHUNG ĐÔI ♥",
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.secondary,
                        ),
                      ),

                      const SizedBox(height: 4),

                      const Text(
                        "Thực & Yến",
                        style: TextStyle(
                          fontFamily: 'Lavanderia',
                          fontSize: 60,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        "NGÀY 30 THÁNG 9 NĂM 2026",
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.secondary,
                        ),
                      ),

                      const Spacer(),

                      InkWell(
                        splashColor: AppColors.primary,
                        onTap: widget.onTapRegister,
                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                            children: [
                              Text(
                                "Xác nhận tham dự",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.secondary,
                                ),
                              ),

                              const SizedBox(height: 4),

                              AnimatedBuilder(
                                animation:
                                _arrowAnimationController,
                                builder: (_, child) {
                                  return Transform.translate(
                                    offset: Offset(
                                      0,
                                      _arrowAnimationController
                                          .value *
                                          10,
                                    ),
                                    child: child,
                                  );
                                },
                                child: SvgPicture.asset(
                                  AppAssets.icArrowDown,
                                  width: 14,
                                  height: 14,
                                  colorFilter:
                                  const ColorFilter.mode(
                                    AppColors.secondary,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(_videoListener);

    _arrowAnimationController.dispose();

    super.dispose();
  }
}