import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wedding/constants/app_colors.dart';

import '../constants/app_assets.dart';

class InvitationView extends StatefulWidget {
  const InvitationView({
    super.key,
    required this.onTapRegister,
  });

  final VoidCallback onTapRegister;

  @override
  State<InvitationView> createState() => _InvitationViewState();
}

class _InvitationViewState extends State<InvitationView>
    with SingleTickerProviderStateMixin {
  late AnimationController _arrowAnimationController;

  @override
  void initState() {
    super.initState();

    _arrowAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _arrowAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    return SizedBox(
      width: double.infinity,
      child: Center(
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          child: SizedBox(
            height: screenHeight,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // ==============================================
                // HEADER IMAGE
                // ==============================================
                Image.asset(
                  AppAssets.heroImage,
                  fit: BoxFit.cover,
                ),

                // ==============================================
                // UI
                // ==============================================
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
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
}
