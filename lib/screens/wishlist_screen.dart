import 'package:flutter/material.dart';
import 'package:task_new/utils/app_colors.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: Center(
        child: Text('Wishlist Screen'),
      ),
    );
  }
}
