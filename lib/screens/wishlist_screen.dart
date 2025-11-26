// lib/screens/wishlist_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_new/controllers/whishlist_provider.dart';
import 'package:task_new/utils/app_colors.dart';
import 'package:task_new/widgets/custom_alert_dialogue.dart';
import 'package:task_new/widgets/product_card.dart';

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlistViewController = ref.watch(wishlistProvider);
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        title: const Text('My Wishlist'),
        actions: [
          if (wishlistViewController.wishlistItems.isNotEmpty)
            TextButton.icon(
              icon: const Icon(Icons.delete_outline),
              label: const Text('Clear All'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => CustomAlertDialog(
                    title: "Clear Wishlist",
                    message: "Are you sure you want to clear your wishlist?",
                    cancelText: "Cancel",
                    confirmText: "Clear",
                    confirmColor: AppColors.error,
                    onConfirm: () {
                      wishlistViewController.clearWishlist();
                      Navigator.of(ctx).pop();
                    },
                  ),
                );
              },
            ),
        ],
      ),
      body: wishlistViewController.wishlistItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.favorite_border,
                    size: 64,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Your wishlist is empty',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  const Text('Add items to your wishlist'),
                ],
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.7,
              ),
              itemCount: wishlistViewController.wishlistItems.length,
              itemBuilder: (ctx, index) {
                final product = wishlistViewController.wishlistItems[index];
                return ProductCard(product: product);
              },
            ),
    );
  }
}
