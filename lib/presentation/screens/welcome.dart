import 'dart:async';
import 'dart:math' as math;
import 'package:dzevent/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({super.key});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> with TickerProviderStateMixin {
  static const int _loopBase = 1000;

  late final PageController _controller;
  late final AnimationController _wave1Controller;
  late final AnimationController _wave2Controller;
  late final AnimationController _floatController;
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

    _wave1Controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();

    _wave2Controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

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
    _wave1Controller.dispose();
    _wave2Controller.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        // Base gradient background
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFEEF2FF),
                Color(0xFFFAF5FF),
                Color(0xFFFFFFFF),
              ],
              stops: [0.0, 0.5, 1.0],
            ),
          ),
        ),
        
        // Animated floating orbs
        AnimatedBuilder(
          animation: _floatController,
          builder: (context, child) {
            return Stack(
              children: [
                // Large orb top right
                Positioned(
                  top: -100 + (_floatController.value * 40),
                  right: -80 + (math.sin(_floatController.value * math.pi) * 20),
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFF6366F1).withOpacity(0.15),
                          const Color(0xFF818CF8).withOpacity(0.08),
                          const Color(0xFF818CF8).withOpacity(0.0),
                        ],
                      ),
                    ),
                  ),
                ),
                // Medium orb left
                Positioned(
                  top: size.height * 0.3 - (_floatController.value * 30),
                  left: -120 + (math.cos(_floatController.value * math.pi * 2) * 15),
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFFA78BFA).withOpacity(0.12),
                          const Color(0xFFC4B5FD).withOpacity(0.06),
                          const Color(0xFFC4B5FD).withOpacity(0.0),
                        ],
                      ),
                    ),
                  ),
                ),
                // Small orb bottom right
                Positioned(
                  bottom: 100 + (_floatController.value * 25),
                  right: 30 - (math.sin(_floatController.value * math.pi * 1.5) * 10),
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFF0310CA).withOpacity(0.1),
                          const Color(0xFF0520E8).withOpacity(0.05),
                          const Color(0xFF0520E8).withOpacity(0.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),

        // Animated wave patterns
        AnimatedBuilder(
          animation: Listenable.merge([_wave1Controller, _wave2Controller]),
          builder: (context, child) {
            return CustomPaint(
              size: Size(size.width, size.height),
              painter: WavePainter(
                animation1: _wave1Controller.value,
                animation2: _wave2Controller.value,
              ),
            );
          },
        ),

        // Main content
        SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),
              // Carousel Section
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 380,
                      child: PageView.builder(
                        controller: _controller,
                        onPageChanged: (index) {
                          setState(() => _currentIndex = index % items.length);
                        },
                        itemBuilder: (context, index) {
                          final item = items[index % items.length];
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Image with enhanced shadow and styling
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF6366F1).withOpacity(0.2),
                                        blurRadius: 30,
                                        offset: const Offset(0, 10),
                                        spreadRadius: 0,
                                      ),
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 15,
                                        offset: const Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(24),
                                    child: Image.asset(
                                      item['image']!,
                                      width: double.infinity,
                                      height: 300,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                // Enhanced text styling with gradient
                                ShaderMask(
                                  shaderCallback: (bounds) => const LinearGradient(
                                    colors: [
                                      Color(0xFF1A1A2E),
                                      Color(0xFF4B5563),
                                    ],
                                  ).createShader(bounds),
                                  child: Text(
                                    item['text']!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      height: 1.4,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Enhanced page indicators
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(items.length, (i) {
                        final isActive = _currentIndex == i;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          width: isActive ? 32 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            gradient: isActive
                                ? const LinearGradient(
                                    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                                  )
                                : null,
                            color: isActive ? null : Colors.grey.withOpacity(0.25),
                            boxShadow: isActive
                                ? [
                                    BoxShadow(
                                      color: const Color(0xFF6366F1).withOpacity(0.4),
                                      blurRadius: 10,
                                      offset: const Offset(0, 3),
                                    ),
                                  ]
                                : [],
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              // Buttons Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Column(
                  children: [
                    // Sign Up Button with enhanced gradient
                    Container(
                      width: double.infinity,
                      height: 58,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF6366F1).withOpacity(0.4),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          print('Sign Up button pressed!');
                          Navigator.pushNamed(context, '/signup');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          local.signUp,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Login Button with glassmorphism effect
                    Container(
                      width: double.infinity,
                      height: 58,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: const Color(0xFF6366F1).withOpacity(0.2),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          print('Login button pressed!');
                          Navigator.pushNamed(context, '/login');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: const Color(0xFF1A1A2E),
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          local.login,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Continue as Guest
                    TextButton(
                      onPressed: () => {
                        Navigator.pushReplacementNamed(context, '/event_feed')
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                      child: Text(
                        local.continueAsGuest,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.none,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class WavePainter extends CustomPainter {
  final double animation1;
  final double animation2;

  WavePainter({required this.animation1, required this.animation2});

  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = const Color(0xFF6366F1).withOpacity(0.05)
      ..style = PaintingStyle.fill;

    final paint2 = Paint()
      ..color = const Color(0xFF8B5CF6).withOpacity(0.04)
      ..style = PaintingStyle.fill;

    // Wave 1
    final path1 = Path();
    path1.moveTo(0, size.height * 0.7);
    
    for (double i = 0; i <= size.width; i++) {
      path1.lineTo(
        i,
        size.height * 0.7 +
            math.sin((i / size.width * 2 * math.pi) + (animation1 * 2 * math.pi)) * 30,
      );
    }
    
    path1.lineTo(size.width, size.height);
    path1.lineTo(0, size.height);
    path1.close();

    // Wave 2
    final path2 = Path();
    path2.moveTo(0, size.height * 0.75);
    
    for (double i = 0; i <= size.width; i++) {
      path2.lineTo(
        i,
        size.height * 0.75 +
            math.sin((i / size.width * 3 * math.pi) + (animation2 * 2 * math.pi)) * 25,
      );
    }
    
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();

    canvas.drawPath(path1, paint1);
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) => true;
}