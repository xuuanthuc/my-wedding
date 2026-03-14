import 'dart:async';

import 'package:flutter/material.dart';

import '../constants/app_assets.dart';

class WeddingCarousel extends StatefulWidget {
  const WeddingCarousel({super.key});

  @override
  State<WeddingCarousel> createState() => _WeddingCarouselState();
}

class _WeddingCarouselState extends State<WeddingCarousel> {

  final List<String> images = [
    "${AppAssets.weddings}1.jpg",
    "${AppAssets.weddings}2.jpg",
    "${AppAssets.weddings}3.jpg",
    "${AppAssets.weddings}4.jpg",
    "${AppAssets.weddings}5.jpg",
  ];

  final ScrollController controller = ScrollController();
  late Timer timer;

  final items = List.generate(5, (i) {
    return Image.asset("${AppAssets.weddings}${i + 1}.jpg", fit: .cover);
  });

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(milliseconds: 40), (_) {
      controller.jumpTo(controller.offset + 1);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      margin: EdgeInsets.symmetric(vertical: 70),
      child: ListView.builder(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final realIndex = index % images.length;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SizedBox(
              width: 250,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(images[realIndex], fit: BoxFit.cover),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    controller.dispose();
    super.dispose();
  }
}
