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

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(AppAssets.introEnvelope)
      ..initialize().then((_) {
        setState(() {});
      });

    _controller.addListener(_videoListener);
  }

  void _videoListener() {
    final value = _controller.value;

    if (value.isCompleted) {
      context.read<WeddingCubit>().introIsCompleted();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeddingCubit, WeddingState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            if (!_controller.value.isCompleted &&
                !_controller.value.isPlaying) {
              setState(() {
                _controller.play();
              });
              await Future.delayed(Duration(seconds: 2));
              setState(() {
                _overlay = Colors.white;
              });
            }
          },
          child: Container(
            width: double.infinity,
            color: Colors.transparent,
            child: Stack(
              fit: .expand,
              children: [
                _controller.value.isInitialized
                    ? FittedBox(
                        fit: .cover,
                        child: SizedBox(
                          width: _controller.value.size.width,
                          height: _controller.value.size.height,
                          child: VideoPlayer(_controller),
                        ),
                      )
                    : Image.asset(AppAssets.introEnvelopeThumb, fit: .cover),
                AnimatedContainer(
                  duration: Duration(seconds: 1),
                  color: _overlay,
                  width: double.infinity,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
