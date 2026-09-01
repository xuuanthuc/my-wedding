import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:wedding/cubit/wedding_cubit.dart';

import '../constants/app_assets.dart';

class IntroView extends StatefulWidget {
  const IntroView({super.key});

  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> {
  late VideoPlayerController _controller;

  Color _overlay = Colors.white.withAlpha(0);

  bool _videoStarted = false;
  bool _initializationFailed = false;
  bool _playRequested = false;
  bool _completedHandled = false;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(
      AppAssets.introEnvelope,
    );

    _controller.addListener(_videoListener);

    _initVideo();
  }

  Future<void> _initVideo() async {
    try {
      await _controller.initialize();

      if (!mounted) return;

      setState(() {});
    } catch (e) {
      debugPrint('Intro video initialize failed: $e');

      _initializationFailed = true;

      if (!mounted) return;

      setState(() {});
    }
  }

  void _videoListener() {
    if (!mounted) return;

    final value = _controller.value;

    // Nếu user đã bấm nhưng video phát sinh lỗi
    // thì bỏ intro luôn, không để user mắc kẹt.
    if (value.hasError && _playRequested) {
      _finishIntro();
      return;
    }

    // Chỉ bỏ thumbnail khi video THỰC SỰ đang chạy
    // và đã render được frame.
    if (!_videoStarted &&
        value.isInitialized &&
        value.isPlaying &&
        value.position > Duration.zero) {
      setState(() {
        _videoStarted = true;
      });
    }

    if (value.isCompleted) {
      _finishIntro();
    }
  }

  void _finishIntro() {
    if (_completedHandled) return;

    _completedHandled = true;

    context.read<WeddingCubit>().introIsCompleted();
  }

  Future<void> _onTap() async {
    if (_completedHandled) return;

    _playRequested = true;

    // Video init lỗi hoặc vẫn không init được:
    // bỏ animation và vào website luôn.
    if (_initializationFailed ||
        !_controller.value.isInitialized) {
      _finishIntro();
      return;
    }

    if (_controller.value.isPlaying) {
      return;
    }

    try {
      await _controller.play();

      // Hiệu ứng fade trắng như code cũ.
      await Future.delayed(
        const Duration(seconds: 2),
      );

      if (!mounted || _completedHandled) return;

      // Chỉ fade nếu video thực sự chạy.
      if (_controller.value.isPlaying) {
        setState(() {
          _overlay = Colors.white;
        });
      }
    } catch (e) {
      debugPrint('Intro video play failed: $e');

      // Không play được thì vào website luôn.
      _finishIntro();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        width: double.infinity,
        color: Colors.transparent,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // =================================================
            // VIDEO
            // =================================================
            if (_controller.value.isInitialized)
              FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              ),

            // =================================================
            // FALLBACK THUMB
            //
            // Luôn giữ ảnh cho đến khi video THỰC SỰ chạy.
            // =================================================
            if (!_videoStarted)
              Image.asset(
                AppAssets.introEnvelopeThumb,
                fit: BoxFit.cover,
              ),

            // =================================================
            // WHITE FADE
            // =================================================
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              color: _overlay,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_videoListener);
    _controller.dispose();

    super.dispose();
  }
}