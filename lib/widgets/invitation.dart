import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';
import 'package:wedding/constants/app_colors.dart';

import '../constants/app_assets.dart';

class InvitationView extends StatefulWidget {
  const InvitationView({super.key, required this.controller});
  final VideoPlayerController controller;

  @override
  State<InvitationView> createState() => _InvitationViewState();
}

class _InvitationViewState extends State<InvitationView>
    with SingleTickerProviderStateMixin {
  late AnimationController _arrowAnimationController;

  @override
  void initState() {
    super.initState();
    autoPlay();
    _arrowAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  void autoPlay() async {
    widget.controller.setLooping(true);
    widget.controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: widget.controller.value.isInitialized
          ? Center(
              child: Stack(
                alignment: .topCenter,
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: 500),
                    child: FittedBox(
                      fit: .fitWidth,
                      child: SizedBox(
                        width: widget.controller.value.size.width,
                        height: widget.controller.value.size.height,
                        child: VideoPlayer(widget.controller),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 40),
                      child: Column(
                        children: [
                          Text(
                            "NGÀY CHUNG ĐÔI",
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.secondary,
                            ),
                          ),
                          Text(
                            ("Thực & Yến"),
                            style: TextStyle(
                              fontFamily: 'Lavanderia',
                              fontSize: 50,
                            ),
                          ),
                          Text(
                            "NGÀY 26 THÁNG 9 NĂM 2026",
                            style: TextStyle(
                              fontSize: 10,
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
                                      fontSize: 10,
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
                                      width: 14,
                                      height: 14,
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
    _arrowAnimationController.dispose();
    super.dispose();
  }
}
