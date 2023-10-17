import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:playtify/screens/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        duration: 3000,
        splash: Image.asset('images/playtify.png',),
        splashIconSize: double.infinity,
        nextScreen: const HomeScreen(),
        splashTransition: SplashTransition.fadeTransition,
    backgroundColor: const Color(0xff180406),);
  }
}
