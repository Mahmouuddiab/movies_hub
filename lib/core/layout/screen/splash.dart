import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movies/core/layout/screen/layout_screen.dart';
import 'package:movies/core/local/secure_storage.dart';
import 'package:movies/core/utils/app_colors.dart';
import 'package:movies/features/auth/presentation/screens/login_screen.dart';

class MovieSplashScreen extends StatefulWidget {
  const MovieSplashScreen({super.key});

  @override
  State<MovieSplashScreen> createState() => _MovieSplashScreenState();
}

class _MovieSplashScreenState extends State<MovieSplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  void _checkAuth() async {

    final token = await SecureStorage.getToken();
    final email = await SecureStorage.getEmail();

    await Future.delayed(const Duration(seconds: 4));

    if (token != null && email != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LayoutScreen(),));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black, // Pure black background
      body: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 2500),
          curve: Curves.easeInQuint, // Slow start, dramatic finish
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Text(
                "MOVIES",
                style: TextStyle(
                  color: Colors.red.shade900, // White text
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  // The text expands slightly as it fades in
                  letterSpacing: 2.0 + (value * 15.0),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}