import 'package:flutter/material.dart';
import 'package:wedding/constants/app_colors.dart';

import '../constants/app_assets.dart';

enum ProgramDirection { left, right }

class DayProgrammeView extends StatelessWidget {
  const DayProgrammeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 120,
          child: Row(
            mainAxisAlignment: .center,
            children: [
              Container(width: 120, height: 1, color: AppColors.line),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text("♥", style: TextStyle(color: AppColors.line)),
              ),
              Container(width: 120, height: 1, color: AppColors.line),
            ],
          ),
        ),
        SizedBox(
          height: 1300,
          width: double.infinity,
          child: Stack(
            alignment: .topCenter,
            children: [
              Positioned.fill(
                child: Image.asset(AppAssets.whiteTexturedPaper, fit: .cover),
              ),
              Positioned.fill(
                child: Column(
                  crossAxisAlignment: .center,
                  children: [
                    const SizedBox(height: 80),
                    Text(
                      'Lịch Trình Lễ Cưới',
                      style: TextStyle(fontFamily: 'Lavanderia', fontSize: 40),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "29 & 30 Tháng 9, 2026",
                      style: TextStyle(color: AppColors.secondary),
                    ),
                    const SizedBox(height: 50),
                    Text(
                      '29 THÁNG 9, 2026',
                      style: TextStyle(
                        color: AppColors.secondary,
                        fontWeight: .w700,
                      ),
                    ),
                    const SizedBox(height: 16),
                    buildRow(
                      direction: .right,
                      labelTime: '08:30',
                      title: 'NHÀ TRAI NẠP TÀI',
                    ),
                    buildRow(
                      direction: .left,
                      labelTime: '09:00',
                      title: 'THƯA CHUYỆN & TRAO LỄ',
                    ),
                    buildRow(
                      direction: .right,
                      labelTime: '09:30',
                      title: 'CHỤP ẢNH LƯU NIỆM',
                    ),
                    buildRow(
                      direction: .left,
                      labelTime: '10:30',
                      title: 'NHÀ GÁI ĐÓN KHÁCH',
                    ),
                    buildRow(
                      direction: .right,
                      labelTime: '11:00',
                      title: 'NHÀ GÁI MỜI KHÁCH',
                    ),
                    buildRow(
                      direction: .left,
                      labelTime: '11:30',
                      title: 'KHAI TIỆC & CHÚC MỪNG',
                    ),
                    buildRow(
                      direction: .right,
                      labelTime: '',
                      title: '',
                    ),
                    buildRow(
                      direction: .right,
                      labelTime: '17:00',
                      title: 'NHÀ TRAI MỜI KHÁCH',
                    ),
                    const SizedBox(height: 28),
                    Text(
                      '30 THÁNG 9, 2026',
                      style: TextStyle(
                        color: AppColors.secondary,
                        fontWeight: .w700,
                      ),
                    ),
                    const SizedBox(height: 16),
                    buildRow(
                      direction: .right,
                      labelTime: '10:00',
                      title: 'NHÀ TRAI ĐÓN KHÁCH',
                    ),
                    buildRow(
                      direction: .left,
                      labelTime: '10:30',
                      title: 'CHỤP ẢNH LƯU NIỆM',
                    ),
                    buildRow(
                      direction: .right,
                      labelTime: '11:00',
                      title: 'ĐÓN DÂU & LỄ CƯỚI CHÍNH',
                    ),
                    buildRow(
                      direction: .left,
                      labelTime: '11:10',
                      title: 'CHỤP ẢNH MỪNG CƯỚI',
                    ),
                    buildRow(
                      direction: .right,
                      labelTime: '11:30',
                      title: 'KHAI TIỆC  & CHÚC MỪNG',
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

  Row buildRow({
    required ProgramDirection direction,
    required String labelTime,
    required String title,
  }) {
    return Row(
      mainAxisAlignment: .center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: .end,
            children: direction == ProgramDirection.left
                ? [
                    Text(labelTime, style: TextStyle(fontWeight: .w900)),
                    const SizedBox(height: 4),
                    Text(title, style: TextStyle(fontSize: 12)),
                  ]
                : [],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(height: 35, width: 1, color: AppColors.secondary),
              Container(height: 1, width: 20, color: AppColors.secondary),
              Container(height: 35, width: 1, color: AppColors.secondary),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            children: direction == ProgramDirection.right
                ? [
                    Text(labelTime, style: TextStyle(fontWeight: .w900)),
                    const SizedBox(height: 4),
                    Text(title, style: TextStyle(fontSize: 12)),
                  ]
                : [],
          ),
        ),
      ],
    );
  }
}
