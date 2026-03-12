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
              if (constraints.maxWidth > 800) {
                return Column(
                  children: [
                    Text(
                      "Sự hiện diện của bạn trong ngày trọng đại sẽ là niềm hạnh phúc lớn đối với tụi mình.",
                      style: TextStyle(fontWeight: .w500),
                      textAlign: .center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Vì vậy, tụi mình rất mong bạn sẽ đến chung vui và chứng kiến khoảnh khắc đặc biệt nhất của hai đứa. ",
                      style: TextStyle(fontWeight: .w500),
                      textAlign: .center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Sự có mặt của bạn sẽ khiến ngày hôm ấy trở nên trọn vẹn hơn.",
                      style: TextStyle(fontWeight: .w500),
                      textAlign: .center,
                    ),
                  ],
                );
              } else {
                return Text(
                  "Sự hiện diện của bạn trong ngày trọng đại sẽ là niềm hạnh phúc lớn đối với tụi mình. Vì vậy, tụi mình rất mong bạn sẽ đến chung vui và chứng kiến khoảnh khắc đặc biệt nhất của hai đứa. Sự có mặt của bạn sẽ khiến ngày hôm ấy trở nên trọn vẹn hơn.",
                  style: TextStyle(fontWeight: .w500),
                  textAlign: .center,
                );
              }
            },
          ),
          const SizedBox(height: 40),
          Container(
            width: 100,
            height: 1,
            color: AppColors.line,
            margin: EdgeInsets.symmetric(vertical: 30),
          ),
          Container(
            constraints: BoxConstraints(maxWidth: 150),
            child: Image.asset(AppAssets.floral, fit: .cover),
          ),
        ],
      ),
    );
  }
}
