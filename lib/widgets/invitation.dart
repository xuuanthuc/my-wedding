import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';
import 'package:wedding/constants/app_colors.dart';

import '../constants/app_assets.dart';

class InvitationView extends StatefulWidget {
  const InvitationView({super.key});

  @override
  State<InvitationView> createState() => _InvitationViewState();
}

class _InvitationViewState extends State<InvitationView>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _controller;
  late AnimationController _arrowAnimationController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(AppAssets.introLanding)
      ..initialize().then((_) {
        setState(() {
          autoPlay();
        });
      });

    _arrowAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  void autoPlay() async {
    _controller.setLooping(true);
    _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: _controller.value.isInitialized
          ? Center(
              child: Stack(
                alignment: .topCenter,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 120),
                    constraints: BoxConstraints(maxWidth: 500, maxHeight: 620),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: FittedBox(
                            fit: .fitWidth,
                            child: SizedBox(
                              width: _controller.value.size.width,
                              height: _controller.value.size.height,
                              child: VideoPlayer(_controller),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 55, bottom: 40),
                      child: Column(
                        children: [
                          Text(
                            "NGÀY CHUNG ĐÔI",
                            style: TextStyle(color: AppColors.secondary),
                          ),
                          Text(
                            ("Thực & Yến"),
                            style: TextStyle(
                              fontFamily: 'Lavanderia',
                              fontSize: 60,
                            ),
                          ),
                          Text(
                            "NGÀY 26 THÁNG 9 NĂM 2026",
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.secondary,
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            splashColor: AppColors.primary,
                            onTap: () {},
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
                                    animation: _arrowAnimationController,
                                    builder: (_, child) {
                                      return Transform.translate(
                                        offset: Offset(
                                          0,
                                          _arrowAnimationController.value * 10,
                                        ),
                                        child: child,
                                      );
                                    },
                                    child: SvgPicture.asset(
                                      AppAssets.icArrowDown,
                                      width: 16,
                                      height: 16,
                                      colorFilter: const ColorFilter.mode(
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
            )
          : SizedBox.shrink(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _arrowAnimationController.dispose();
    super.dispose();
  }
}
