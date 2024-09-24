import 'dart:async';
import 'package:flutter/material.dart';
import 'package:notes_bloc/views/home_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const id = 'splash1';

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller1;
  late Animation<double> _fadeAnimation1;
  late AnimationController _controller2;
  late Animation<double> _fadeAnimation2;
  //late Animation<double> _rotationAnimation;
  // late bool _onboarded = false;
  // void _setOnboardingState() async {
  //   _onboarded = await BlocProvider.of<LanguageCubit>(context).onBoarded;
  // }

  @override
  void initState() {
    super.initState();
    // _setOnboardingState();
    _controller1 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // Fade Animation
    _fadeAnimation1 = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller1,
        curve: const Interval(0.1, 1, curve: Curves.easeInOut),
      ),
    );
    _fadeAnimation2 = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller2,
        curve: const Interval(0.9, 1, curve: Curves.easeIn),
      ),
    );

    // Start the animation
    _controller1.forward();
    _controller2.forward();
    Timer(
      const Duration(milliseconds: 6000),
      () {
        _controller1.stop();
        Navigator.pushReplacementNamed(context, HomeView.id);
        // if (!_onboarded) {
        //   Navigator.pushReplacementNamed(context, LanguageSettingView.id);
        // } else {
        //   Navigator.pushReplacementNamed(context, HomeView.id);
        // }
      },
    );
  }

  @override
  void dispose() {
    _controller1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Stack(
                children: [
                  AnimatedBuilder(
                    animation: _fadeAnimation1,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _fadeAnimation1.value,
                        child: child,
                      );
                    },
                    child: Image.asset(
                      'assets/images/notes.png',
                      width: width * 0.8,
                    ),
                  ),
                  AnimatedBuilder(
                    animation: _fadeAnimation2,
                    builder: (context, child) {
                      return Positioned(
                        left: (_fadeAnimation2.value - 1.01) * width * 0.9,
                        child: child!,
                      );
                    },
                    child: Image.asset(
                      'assets/images/bloc.png',
                      width: MediaQuery.of(context).size.width * 0.8,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
