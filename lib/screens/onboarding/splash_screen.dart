import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_new/screens/auth/auth_wrapper.dart';
import 'package:task_new/utils/app_colors.dart';
import 'package:task_new/utils/app_constants.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _navigateNext();
  }

  Future<void> _navigateNext() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    // User is not logged in or verification failed, go to onboarding
    // Navigator.pushReplacementNamed(context, /* AppRoutes.onBoardingScreen */);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AuthWrapper()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkGreen,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo inside branded circle
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset(
                AppConstants.appLogoAssert,
                fit: BoxFit.contain,
              ),
            ),

            // Loader
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                AppColors.lightBackground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
