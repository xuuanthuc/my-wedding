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
          height: 800,
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
                      "26 Tháng 9, 2026",
                      style: TextStyle(color: AppColors.secondary),
                    ),
                    const SizedBox(height: 80),
                    buildRow(
                      direction: .right,
                      labelTime: '10:00',
                      title: 'ĐÓN KHÁCH',
                    ),
                    buildRow(
                      direction: .left,
                      labelTime: '11:00',
                      title: 'KHAI MẠC',
                    ),
                    buildRow(
                      direction: .right,
                      labelTime: '11:45',
                      title: 'LỄ THÀNH HÔN',
                    ),
                    buildRow(
                      direction: .left,
                      labelTime: '12:00',
                      title: 'KHAI TIỆC',
                    ),
                    buildRow(
                      direction: .right,
                      labelTime: '01:00',
                      title: 'GIAO LƯU',
                    ),
                    buildRow(
                      direction: .left,
                      labelTime: '01:30',
                      title: 'KẾT THÚC',
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
