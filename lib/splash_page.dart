import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _dotScale;
  late final Animation<double> _textOpacity;
  late final Animation<double> _textOffsetX;

  late final Animation<double> _rippleScale;
  late final Animation<double> _rippleOpacity;

  late final Animation<double> _logoOpacity;
  late final Animation<Offset> _logoSlide;
  late final Animation<double> _buttonOpacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..forward();

    // 0.0–0.25 : dot muncul di tengah
    _dotScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.25, curve: Curves.easeOutBack),
      ),
    );

    // 0.15–0.35 : teks "TUTOR" fade in dan sedikit geser
    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.15, 0.35, curve: Curves.easeIn),
      ),
    );

    _textOffsetX = Tween<double>(begin: -30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.15, 0.35, curve: Curves.easeOut),
      ),
    );

    // 0.35–0.7 : dot berkembang jadi ripple
    _rippleScale = Tween<double>(begin: 0.0, end: 3.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.35, 0.7, curve: Curves.easeOutCubic),
      ),
    );

    _rippleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.35, 0.7, curve: Curves.easeInOut),
      ),
    );

    // 0.6–1.0 : logo + tombol muncul (state akhir)
    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 1.0, curve: Curves.easeIn),
      ),
    );

    _logoSlide = Tween<Offset>(
      begin: const Offset(0.0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
      ),
    );

    _buttonOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.7, 1.0, curve: Curves.easeIn),
      ),
    );

    // Setelah animasi selesai, misal pindah ke halaman berikutnya
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // TODO: ganti ke halaman login/berikutnya
        // Navigator.of(context).pushReplacement(...);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFBFD7FF), // biru muda atas
              Color(0xFF417BFF), // biru tua bawah
            ],
          ),
        ),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                // Ripple circles
                Opacity(
                  opacity: _rippleOpacity.value,
                  child: _buildRipples(size),
                ),

                // Dot di tengah (base circle)
                Transform.scale(
                  scale: _dotScale.value,
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),

                // Teks "TUTOR" + dot kecil di kanan (frame kedua)
                Positioned(
                  top: size.height * 0.4,
                  child: Opacity(
                    opacity: _textOpacity.value,
                    child: Transform.translate(
                      offset: Offset(_textOffsetX.value, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'TUTOR',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 4,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Logo card + tombol (frame terakhir)
                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SlideTransition(
                        position: _logoSlide,
                        child: Opacity(
                          opacity: _logoOpacity.value,
                          child: _buildLogoCard(),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Opacity(
                        opacity: _buttonOpacity.value,
                        child: _buildPrimaryButton(),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildRipples(Size size) {
    final baseSize = size.width * 0.7 * _rippleScale.value;

    List<Widget> circles = [];
    for (int i = 0; i < 3; i++) {
      final factor = 1 + i * 0.4;
      circles.add(
        Container(
          width: baseSize * factor,
          height: baseSize * factor,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withOpacity(0.4 - i * 0.1),
              width: 2,
            ),
          ),
        ),
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: circles,
    );
  }

  Widget _buildLogoCard() {
    return Container(
      width: 140,
      height: 180,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            blurRadius: 16,
            offset: const Offset(0, 8),
            color: Colors.black.withOpacity(0.15),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.school_rounded,
            size: 48,
            color: Color(0xFF417BFF),
          ),
          SizedBox(height: 12),
          Text(
            'TUTOR',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
              color: Color(0xFF417BFF),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32),
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFF101935),
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Center(
        child: Text(
          'Create Account',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
