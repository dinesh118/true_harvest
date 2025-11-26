import 'package:flutter/material.dart';
import 'package:task_new/utils/app_colors.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: Center(
        child: Text('Subscription Screen'),
      ),
    );
  }
}
