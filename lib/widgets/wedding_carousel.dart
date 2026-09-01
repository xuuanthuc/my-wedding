import 'dart:async';

import 'package:flutter/material.dart';

import '../constants/app_assets.dart';

class WeddingCarousel extends StatefulWidget {
  const WeddingCarousel({super.key});

  @override
  State<WeddingCarousel> createState() => _WeddingCarouselState();
}

class _WeddingCarouselState extends State<WeddingCarousel> {
  static const double _imageWidth = 250;
  static const double _imagePadding = 12;
  static const double _itemExtent = _imageWidth + (_imagePadding * 2);
  static const int _initialIndex = 3000;

  static const List<String> images = [
    '${AppAssets.weddings}ING00089.jpg',
    '${AppAssets.weddings}ING00135.jpg',
    '${AppAssets.weddings}ING09004.jpg',
    '${AppAssets.weddings}ING09093.jpg',
    '${AppAssets.weddings}ING09149.jpg',
    '${AppAssets.weddings}ING09190.jpg',
    '${AppAssets.weddings}ING09216.jpg',
    '${AppAssets.weddings}ING09230.jpg',
    '${AppAssets.weddings}ING09306.jpg',
    '${AppAssets.weddings}ING09327.jpg',
    '${AppAssets.weddings}ING09335.jpg',
    '${AppAssets.weddings}ING09357.jpg',
    '${AppAssets.weddings}ING09379.jpg',
    '${AppAssets.weddings}ING09505.jpg',
    '${AppAssets.weddings}ING09526.jpg',
    '${AppAssets.weddings}ING09548.jpg',
    '${AppAssets.weddings}ING09582.jpg',
    '${AppAssets.weddings}ING09608.jpg',
    '${AppAssets.weddings}ING09710.jpg',
    '${AppAssets.weddings}ING09718.jpg',
    '${AppAssets.weddings}ING09750.jpg',
    '${AppAssets.weddings}ING09757.jpg',
    '${AppAssets.weddings}ING09777.jpg',
    '${AppAssets.weddings}ING09822.jpg',
    '${AppAssets.weddings}ING09842.jpg',
    '${AppAssets.weddings}ING09899.jpg',
    '${AppAssets.weddings}ING09910.jpg',
    '${AppAssets.weddings}ING09927.jpg',
    '${AppAssets.weddings}ING09939.jpg',
    '${AppAssets.weddings}ING09997.jpg',
  ];

  final ScrollController controller = ScrollController(
    initialScrollOffset: _initialIndex * _itemExtent,
  );
  Timer? _autoScrollTimer;
  Timer? _resumeAutoScrollTimer;
  bool _isUserInteracting = false;

  @override
  void initState() {
    super.initState();

    _autoScrollTimer = Timer.periodic(const Duration(milliseconds: 40), (_) {
      if (controller.hasClients && !_isUserInteracting) {
        controller.jumpTo(controller.offset + 1);
      }
    });
  }

  void _pauseAutoScroll() {
    _isUserInteracting = true;
    _resumeAutoScrollTimer?.cancel();
  }

  void _resumeAutoScroll() {
    _resumeAutoScrollTimer?.cancel();
    _resumeAutoScrollTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) _isUserInteracting = false;
    });
  }

  void _openImagePreview(BuildContext context, String imagePath) {
    _pauseAutoScroll();
    showDialog<void>(
      context: context,
      barrierColor: Colors.black87,
      builder: (dialogContext) {
        return Dialog.fullscreen(
          backgroundColor: Colors.black,
          child: Stack(
            children: [
              Center(
                child: InteractiveViewer(
                  minScale: 1,
                  maxScale: 4,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                    frameBuilder: _imageFrameBuilder,
                  ),
                ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: IconButton(
                  tooltip: 'Đóng',
                  color: Colors.white,
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(dialogContext).pop(),
                ),
              ),
            ],
          ),
        );
      },
    ).whenComplete(_resumeAutoScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      margin: EdgeInsets.symmetric(vertical: 70),
      child: Listener(
        onPointerDown: (_) => _pauseAutoScroll(),
        onPointerUp: (_) => _resumeAutoScroll(),
        onPointerCancel: (_) => _resumeAutoScroll(),
        child: ListView.builder(
          controller: controller,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemExtent: _itemExtent,
          itemBuilder: (context, index) {
            final imagePath = images[index % images.length];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: _imagePadding),
              child: SizedBox(
                width: _imageWidth,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => _openImagePreview(context, imagePath),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        frameBuilder: _imageFrameBuilder,
                        errorBuilder: (context, error, stackTrace) =>
                            const _CarouselImagePlaceholder(
                              showError: true,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _imageFrameBuilder(
    BuildContext context,
    Widget child,
    int? frame,
    bool wasSynchronouslyLoaded,
  ) {
    if (wasSynchronouslyLoaded || frame != null) return child;
    return const _CarouselImagePlaceholder();
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _resumeAutoScrollTimer?.cancel();
    controller.dispose();
    super.dispose();
  }
}

class _CarouselImagePlaceholder extends StatelessWidget {
  const _CarouselImagePlaceholder({this.showError = false});

  final bool showError;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFFF4EEE7),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              showError ? Icons.broken_image_outlined : Icons.photo_outlined,
              color: const Color(0xFFB19878),
              size: 32,
            ),
            const SizedBox(height: 10),
            if (showError)
              const Text(
                'Không thể tải ảnh',
                style: TextStyle(color: Color(0xFFB19878), fontSize: 12),
              )
            else
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Color(0xFFB19878),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
