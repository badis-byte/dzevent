import 'dart:async';
import 'package:dzevent/l10n/app_localizations.dart';
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
    {'image': 'assets/images/hackathon.jpg', 'text': 'Connect with people'},
    {'image': 'assets/images/concert.jpg', 'text': 'Relax and do what you love'},
    {'image': 'assets/images/lecture.jpg', 'text': 'Teach, Learn and thrive'},
  ];

  @override
  void initState() {
    super.initState();

    final int initialPage = items.length * _loopBase;
    _controller = PageController(initialPage: initialPage);
    _currentIndex = initialPage % items.length;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _timer = Timer.periodic(const Duration(seconds: 5), (_) {
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
    final local = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      color: const Color.fromARGB(255, 240, 242, 245),
      child: Column(
        children: [
          SizedBox(height: 55,),
          SizedBox(
            height: 350,
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
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.transparent,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          item['image']!,
                          width: double.infinity,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                      item['text']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A1A),
                        height: 1.3, // line height
                        shadows: [
                          Shadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(1, 2),
                          )
                        ],
                      ),
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
          const SizedBox(height: 65),
          ElevatedButton(
            onPressed: () {
              print('Sign Up button pressed!');
              Navigator.pushNamed(context, '/signup');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 3, 16, 202),
              foregroundColor: Colors.white,
              minimumSize: const Size(400, 60),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5,
            ),
            child: Text(
              local.signUp,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 17),
          ElevatedButton(
            onPressed: () {
              print('Login button pressed!');
              Navigator.pushNamed(context, '/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 220, 216, 216),
              foregroundColor: Colors.black,
              minimumSize: const Size(400, 60),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5,
            ),
            child: Text(
              local.login,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: TextButton(
              onPressed: () => {
                Navigator.pushReplacementNamed(context, '/event_feed')
              },
              child: Text(
                local.continueAsGuest,
                style: const TextStyle(
                  color: Color.fromARGB(255, 81, 78, 78),
                  fontSize: 15,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
