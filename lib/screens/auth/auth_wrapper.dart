// lib/screens/auth/auth_wrapper.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_new/routes/app_routes.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user != null) {
            // User is signed in - navigate to main screen
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AppRoutes.navigateAndClearStack(context, AppRoutes.main);
            });
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          // User is not signed in - navigate to login
          WidgetsBinding.instance.addPostFrameCallback((_) {
            AppRoutes.navigateAndReplace(context, AppRoutes.login);
          });
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        // Show loading indicator while checking auth state
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
