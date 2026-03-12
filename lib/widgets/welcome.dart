import 'package:flutter/material.dart';
import 'package:wedding/constants/app_assets.dart';
import 'package:wedding/constants/app_colors.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.primaryBackground,
      padding: EdgeInsets.symmetric(vertical: 60, horizontal: 30),
      child: Column(
        children: [
          Text(
            'Chào mừng!',
            style: TextStyle(fontFamily: 'Lavanderia', fontSize: 40),
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return Column(
                  children: [
                    Text(
                      "Chúng tôi trân trọng mời bạn cùng đến chung vui trong ngày cưới của chúng tôi. ",
                      style: TextStyle(fontWeight: .w500),
                      textAlign: .center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Rất mong được đón tiếp và chia sẻ khoảnh khắc đặc biệt này cùng gia đình và những người thân yêu.",
                      style: TextStyle(fontWeight: .w500),
                      textAlign: .center,
                    ),
                  ],
                );
              } else {
                return Text(
                  "Chúng tôi trân trọng mời bạn cùng đến chung vui trong ngày cưới của chúng tôi. Rất mong được đón tiếp và chia sẻ khoảnh khắc đặc biệt này cùng gia đình và những người thân yêu.",
                  style: TextStyle(fontWeight: .w500),
                  textAlign: .center,
                );
              }
            },
          ),
          const SizedBox(height: 40),
          Container(width: 100, height: 1, color: AppColors.line, margin: EdgeInsets.symmetric(vertical: 30),),
          Container(
            constraints: BoxConstraints(maxWidth: 150),
            child: Image.asset(AppAssets.floral, fit: .cover),
          ),
        ],
      ),
    );
  }
}
