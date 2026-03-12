import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedding/constants/app_assets.dart';
import 'package:wedding/cubit/wedding_cubit.dart';

import '../constants/app_colors.dart';

class CountdownView extends StatefulWidget {
  const CountdownView({super.key});

  @override
  State<CountdownView> createState() => _CountdownViewState();
}

class _CountdownViewState extends State<CountdownView> {
  late Timer timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      context.read<WeddingCubit>().countRemainingTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(AppAssets.whiteTexturedPaper, fit: .fitWidth),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: .center,
              crossAxisAlignment: .center,
              children: [
                const SizedBox(height: 10),
                Text(
                  'Khoảnh khắc chờ đợi',
                  style: TextStyle(fontFamily: 'Lavanderia', fontSize: 40),
                ),
                const SizedBox(height: 10),
                Text(
                  "NGÀY 26 THÁNG 9 NĂM 2026",
                  style: TextStyle(color: AppColors.secondary),
                ),
                const SizedBox(height: 10),
                BlocBuilder<WeddingCubit, WeddingState>(
                  buildWhen: (p, c) => p.diffTime != c.diffTime,
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: .center,
                      crossAxisAlignment: .center,
                      children: [
                        countRemainingText(
                          (state.diffTime?.inDays ?? 0).toString(),
                          'NGÀY',
                        ),
                        Container(height: 40, width: 1, color: AppColors.line),
                        countRemainingText(
                          ((state.diffTime?.inHours ?? 0) % 24).toString(),
                          'GIỜ',
                        ),
                        Container(height: 40, width: 1, color: AppColors.line),
                        countRemainingText(
                          ((state.diffTime?.inMinutes ?? 0) % 60).toString(),
                          'PHÚT',
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget countRemainingText(String time, String label) {
    return SizedBox(
      width: 100,
      height: 120,
      child: Column(
        crossAxisAlignment: .center,
        mainAxisAlignment: .center,
        children: [
          Text(time, style: TextStyle(fontFamily: 'Lavanderia', fontSize: 50)),
          Text(
            label,
            style: TextStyle(fontSize: 11, color: AppColors.secondary),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
