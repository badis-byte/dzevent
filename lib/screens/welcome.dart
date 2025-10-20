import 'dart:async';
import 'package:flutter/material.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({super.key});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  static const int _loopBase = 1000;

  late final PageController _controller;
  int _currentIndex = 0;
  Timer? _timer;

  final List<Map<String, String>> items = [
    {'image': 'assets/icons/run.png', 'text': 'Stay fit with our running plan'},
    {'image': 'assets/icons/yoga.png', 'text': 'Relax and focus with daily yoga'},
    {'image': 'assets/icons/food.png', 'text': 'Eat healthy, live strong'},
  ];

  @override
  void initState() {
    super.initState();

    // Make initialPage a multiple of items.length so modulo = 0 (starts on first item).
    final int initialPage = items.length * _loopBase; // e.g., 3 * 1000 = 3000
    _controller = PageController(initialPage: initialPage);

    // Keep dots in sync from the first frame.
    _currentIndex = initialPage % items.length; // will be 0

    // Start auto-scroll after first frame to avoid the initial jump.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _timer = Timer.periodic(const Duration(seconds: 3), (_) {
        if (_controller.hasClients) {
          _controller.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        SizedBox(
          height: 400,
          child: PageView.builder(
            controller: _controller,
            onPageChanged: (index) {
              setState(() => _currentIndex = index % items.length);
            },
            itemBuilder: (context, index) {
              final item = items[index % items.length];
              return AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        item['image']!,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item['text']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(items.length, (i) {
            final isActive = _currentIndex == i;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: isActive ? 12 : 8,
              height: isActive ? 12 : 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive ? Colors.blue : Colors.grey.withOpacity(0.4),
              ),
            );
          }),
        ),
        
      ],
    );
  }
}
