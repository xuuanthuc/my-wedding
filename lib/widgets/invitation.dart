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

    if (!oldWidget.shouldPlay && widget.shouldPlay) {
      _maybePlayVideo();
    }
  }

  void _videoListener() {
    if (!mounted) return;

    final value = widget.controller.value;

    // Video lỗi -> quay lại thumbnail.
    if (value.hasError) {
      if (_videoStarted) {
        setState(() {
          _videoStarted = false;
        });
      }

      return;
    }

    // Video vừa initialize xong.
    if (widget.shouldPlay &&
        value.isInitialized &&
        !_playAttempted) {
      _tryPlayVideo();
    }

    // Chỉ hiện video khi thực sự đã chạy và có frame.
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
      await widget.controller.setVolume(0);
      await widget.controller.play();
    } catch (e) {
      debugPrint(
        'Hero video play failed. Using static image: $e',
      );

      // Không cần làm gì.
      // Thumbnail vẫn tiếp tục hiển thị.
    }
  }

  @override
  Widget build(BuildContext context) {
    final value = widget.controller.value;
    final initialized = value.isInitialized;

    // Khi video init được thì dùng đúng tỷ lệ video.
    // Nếu iPhone init video lỗi thì fallback về tỷ lệ hero 16:9.
    final double aspectRatio =
    initialized && value.aspectRatio > 0
        ? value.aspectRatio
        : 16 / 9;

    return SizedBox(
      width: double.infinity,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          child: AspectRatio(
            aspectRatio: aspectRatio,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // ==============================================
                // FALLBACK IMAGE
                //
                // Luôn nằm bên dưới.
                // Không được quyết định kích thước layout.
                // ==============================================
                Image.asset(
                  AppAssets.introLandingThumb,
                  fit: BoxFit.cover,
                ),

                // ==============================================
                // VIDEO
                //
                // Chỉ phủ lên thumbnail khi thực sự chạy.
                // ==============================================
                if (initialized && _videoStarted)
                  FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: value.size.width,
                      height: value.size.height,
                      child: VideoPlayer(
                        widget.controller,
                      ),
                    ),
                  ),

                // ==============================================
                // UI / TEXT
                // ==============================================
                Padding(
                  padding: EdgeInsets.only(
                    top: initialized
                        ? value.size.height * 0.02
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
              ],
            ),
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