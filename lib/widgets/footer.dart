import 'package:flutter/material.dart';
import 'package:wedding/constants/app_assets.dart';

import '../constants/app_colors.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 80,
          margin: EdgeInsets.all(80),
          child: Image.asset(AppAssets.ring),
        ),
        SizedBox(
          height: 450,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  AppAssets.whiteTexturedPaper,
                  fit: .fitWidth,
                ),
              ),
              Positioned.fill(
                child: Column(
                  mainAxisAlignment: .center,
                  crossAxisAlignment: .center,
                  children: [
                    Text(
                      ("Xuân Thực"),
                      style: TextStyle(
                        fontFamily: 'Lavanderia',
                        fontSize: 60,
                      ),
                    ),
                    Text(
                      ("&"),
                      style: TextStyle(
                        fontFamily: 'Lavanderia',
                        fontSize: 40,
                      ),
                    ),
                    Text(
                      ("Ngọc Yến"),
                      style: TextStyle(
                        fontFamily: 'Lavanderia',
                        fontSize: 60,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "26 THÁNG 9, 2026",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: .w700,
                        color: AppColors.primaryBackground,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
