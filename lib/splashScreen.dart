import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_application_4/onboarding/introduction.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay for 3 minutes (180,000 milliseconds) and then navigate to the home page.
    Future.delayed(const Duration(milliseconds:180000), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => const Introduction(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: const SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius:203,
                backgroundImage: AssetImage('assets/Marham.png'),
              ),
            
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFF37B6FF),
      nextScreen: const Introduction(),
      splashIconSize: 300,
      duration: 2000,
      pageTransitionType: PageTransitionType.leftToRightWithFade,
    );
  }
}
