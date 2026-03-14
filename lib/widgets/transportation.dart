import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wedding/constants/app_assets.dart';
import 'package:wedding/constants/app_colors.dart';

class TransportationView extends StatelessWidget {
  const TransportationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          height: 250,
          padding: EdgeInsets.all(60),
          child: Image.asset(AppAssets.cupid),
        ),
        const SizedBox(height: 80),
        Text(
          'Di chuyển',
          style: TextStyle(fontFamily: 'Lavanderia', fontSize: 40),
        ),
        Container(
          constraints: BoxConstraints(maxWidth: 600),
          padding: EdgeInsets.all(40),
          child: Text(
            "Chúng tôi đã bố trí xe đưa đón từ trung tâm Hà Nội đến tiệc cưới nhà trai để bạn có thể tận hưởng buổi lễ mà không cần lo lắng.",
            textAlign: .center,
            style: TextStyle(color: AppColors.secondary),
          ),
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.all(30),
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
              SvgPicture.asset(
                AppAssets.icLocation,
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  AppColors.secondary,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Toà nhà Sannam, 78 Duy Tân, Cầu Giấy, Hà Nội - Vietnam",
                textAlign: .center,
                style: TextStyle(fontWeight: .w500),
              ),
              const SizedBox(height: 24),
              InkWell(
                onTap: () async {
                  await launchUrl(
                    Uri.parse('https://maps.app.goo.gl/PbpsyKUDWHAsH7AS9'),
                  );
                },
                child: Column(
                  mainAxisSize: .min,
                  children: [
                    Text(
                      "GOOGLE MAPS",
                      style: TextStyle(
                        color: AppColors.secondary,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(width: 90, height: 1, color: AppColors.line),
                  ],
                ),
              ),
              Container(
                width: 60,
                height: 1,
                color: AppColors.line,
                margin: EdgeInsets.all(25),
              ),
              SvgPicture.asset(
                AppAssets.icCar,
                width: 22,
                height: 22,
                colorFilter: const ColorFilter.mode(
                  AppColors.secondary,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Từ toà nhà Sannam: 08:00",
                style: TextStyle(fontSize: 12, color: AppColors.primary),
              ),
              const SizedBox(height: 4),
              Text(
                "Trở lại Hà Nội: 14:00",
                style: TextStyle(fontSize: 12, color: AppColors.primary),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 250,
          padding: EdgeInsets.all(60),
          child: Image.asset(AppAssets.swans),
        ),
      ],
    );
  }
}
