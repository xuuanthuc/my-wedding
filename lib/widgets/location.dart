import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wedding/constants/app_assets.dart';
import 'package:wedding/constants/app_colors.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'dart:html' as html;
import 'dart:ui_web' as ui;

class LocationCelebrateView extends StatefulWidget {
  const LocationCelebrateView({super.key});

  @override
  State<LocationCelebrateView> createState() => _LocationCelebrateViewState();
}

class _LocationCelebrateViewState extends State<LocationCelebrateView> {
  final html.IFrameElement _iframeElement = html.IFrameElement();

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      _iframeElement.src =
          'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1873.6544528073412!2d105.86264238840806!3d20.07936989813804!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31366172dd0dab39%3A0x7f2de43c42966a9f!2sSinh%20th%C3%A1i%20Ho%C3%A0ng%20Gia%202!5e0!3m2!1sen!2s!4v1773380482372!5m2!1sen!2s" width="800" height="230" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade'; // URL to load
      _iframeElement.style.border = 'none';
      ui.platformViewRegistry.registerViewFactory(
        'iframe-view',
        (int viewId) => _iframeElement,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryBackground,
      child: Column(
        children: [
          const SizedBox(height: 80),
          Text(
            'Địa điểm',
            style: TextStyle(
              fontFamily: 'Lavanderia',
              fontSize: 40,
              color: Colors.white,
            ),
          ),

          Text("Nơi chúng ta tổ chức", style: TextStyle(color: Colors.white)),
          const SizedBox(height: 20),
          Container(
            margin: EdgeInsets.all(20).copyWith(bottom: 120),
            decoration: BoxDecoration(
              color: Color(0xFFFEFEFE),
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
            padding: EdgeInsets.all(30),
            constraints: BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  constraints: BoxConstraints(maxWidth: 500),
                  child: Image.asset(AppAssets.royalEcological),
                ),
                const SizedBox(height: 8),
                Text(
                  'Sinh Thái Hoàng Gia ',
                  style: TextStyle(
                    fontFamily: 'Lavanderia',
                    fontSize: 25,
                    color: AppColors.primary,
                  ),
                  textAlign: .center,
                ),
                Container(
                  height: 1,
                  margin: EdgeInsets.symmetric(vertical: 30),
                  width: double.infinity,
                  color: AppColors.line,
                ),
                Row(
                  crossAxisAlignment: .center,
                  mainAxisAlignment: .center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(
                        "26 Tháng 9, 2026",
                        style: TextStyle(color: AppColors.secondary),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Container(
                        height: 2,
                        width: 2,
                        color: AppColors.line,
                        margin: EdgeInsets.all(10),
                      ),
                    ),
                    Text(
                      ("12:00"),
                      style: TextStyle(fontFamily: 'Lavanderia', fontSize: 30),
                    ),
                  ],
                ),
                Container(
                  height: 1,
                  margin: EdgeInsets.symmetric(vertical: 30),
                  width: 60,
                  color: AppColors.line,
                ),
                Text("Hai Bà Trưng, Bỉm Sơn"),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 20),
                  child: Text(
                    "Thanh Hoá - Việt Nam",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: .w500,
                      color: AppColors.secondary,
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: SizedBox(
                    width: 800,
                    height: 230,
                    child: HtmlElementView(viewType: 'iframe-view'),
                  ),
                ),
                const SizedBox(height: 12),
                InkWell(
                  onTap: () async {
                    await launchUrl(
                      Uri.parse('https://maps.app.goo.gl/fpZJys8TR4ZuUDYn8'),
                    );
                  },
                  child: Column(
                    mainAxisSize: .min,
                    children: [
                      Row(
                        mainAxisAlignment: .center,
                        mainAxisSize: .min,
                        children: [
                          SvgPicture.asset(
                            AppAssets.icLocation,
                            width: 14,
                            height: 14,
                            colorFilter: const ColorFilter.mode(
                              AppColors.primary,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text("MỞ TRÊN MAPS"),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Container(width: 140, height: 1, color: AppColors.line),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
