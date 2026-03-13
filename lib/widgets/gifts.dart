import 'package:flutter/material.dart';
import 'package:wedding/constants/app_assets.dart';
import 'package:wedding/constants/app_colors.dart';

class GiftsView extends StatelessWidget {
  const GiftsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 300,
          padding: EdgeInsets.all(60),
          child: Image.asset(AppAssets.champagneTower),
        ),
        SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(AppAssets.royalEcologicalPic, fit: .cover),
              ),
              Container(color: Colors.white30),
              Center(
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                  padding: EdgeInsets.all(40),
                  constraints: BoxConstraints(maxWidth: 800),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        spreadRadius: 0,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Mừng cưới',
                        style: TextStyle(
                          fontFamily: 'Lavanderia',
                          fontSize: 40,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Text(
                          "Sự hiện diện của quý vị trong ngày vui của chúng tôi đã là món quà quý giá nhất. Nếu quý vị muốn gửi tặng lời chúc phúc, xin vui lòng tham khảo thông tin tài khoản bên dưới.",
                          textAlign: .center,
                          style: TextStyle(fontWeight: .w500),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryBackground,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            if (constraints.maxWidth > 400) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: .start,
                                      children: [
                                        Text.rich(
                                          TextSpan(
                                            text: 'VIETIN',
                                            style: TextStyle(fontWeight: .w700),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: 'BANK',
                                                style: TextStyle(
                                                  color: AppColors.secondary,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text("DO XUAN THUC"),
                                        const SizedBox(height: 8),
                                        Text("101868163046"),
                                      ],
                                    ),
                                  ),
                                  Image.asset(
                                    AppAssets.thucBank,
                                    width: 100,
                                    height: 100,
                                  ),
                                ],
                              );
                            } else {
                              return Column(
                                crossAxisAlignment: .center,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      text: 'VIETIN',
                                      style: TextStyle(fontWeight: .w700),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'BANK',
                                          style: TextStyle(
                                            color: AppColors.secondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text("DO XUAN THUC"),
                                  const SizedBox(height: 4),
                                  Text("101868163046"),
                                  const SizedBox(height: 10),
                                  Image.asset(
                                    AppAssets.thucBank,
                                    width: 100,
                                    height: 100,
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 25),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryBackground,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            if (constraints.maxWidth > 400) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: .start,
                                      children: [
                                        Text.rich(
                                          TextSpan(
                                            text: 'TECHCOM',
                                            style: TextStyle(fontWeight: .w700),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: 'BANK',
                                                style: TextStyle(
                                                  color: AppColors.secondary,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text("NGUYEN THI NGOC YEN"),
                                        const SizedBox(height: 8),
                                        Text("9096881998"),
                                      ],
                                    ),
                                  ),
                                  Image.asset(
                                    AppAssets.yenBank,
                                    width: 100,
                                    height: 100,
                                  ),
                                ],
                              );
                            } else {
                              return Column(
                                crossAxisAlignment: .center,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      text: 'TECHCOM',
                                      style: TextStyle(fontWeight: .w700),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'BANK',
                                          style: TextStyle(
                                            color: AppColors.secondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text("NGUYEN THI NGOC YEN"),
                                  const SizedBox(height: 4),
                                  Text("9096881998"),
                                  const SizedBox(height: 10),
                                  Image.asset(
                                    AppAssets.yenBank,
                                    width: 100,
                                    height: 100,
                                  ),
                                ],
                              );
                            }
                          },
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
    );
  }
}
