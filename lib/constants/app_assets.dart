import 'package:flutter/foundation.dart';

class AppAssets {
  AppAssets._();

  static const releasePath = kDebugMode ? '' : 'assets/';
  static const String introLanding = "assets/hero-video-new-G6oopIOA.mp4";
  static const String introEnvelope = "assets/intro-envelope-HFQPjaLP.mp4";
  static const String introEnvelopeThumb =
      "${releasePath}intro-envelope-poster-Bi8UMZ1A.jpg";
  static const String introLandingThumb =
      "${releasePath}hero-video-new-poster-G6oopIOA.png";
  static const String backgroundMusic = "wedding-march-CDiiiBMO.mp3";
  static const String whiteTexturedPaper =
      "${releasePath}white-textured-paper-KasY8RAJ.png";
  static const String icVolumeX = "assets/volume-x.svg";
  static const String icVolume = "assets/volume.svg";
  static const String icArrowDown = "assets/arrow-down.svg";
  static const String floral = "${releasePath}floral-vase-6x28LN74.png";
}
