import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_new/controllers/products_controller.dart';
import 'package:task_new/models/product_model.dart';
import 'package:task_new/screens/subscriptions/subscription_plan_screen.dart';
import 'package:task_new/utils/app_colors.dart';

class SelectProductScreen extends ConsumerWidget {
  const SelectProductScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsController = ref.watch(groceryHomeControllerProvider);
    final products = productsController.products;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Product'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  product.imageUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                product.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${product.units.length} variants available',
                style: const TextStyle(fontSize: 12),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Navigate to unit selection or directly to subscription plan if only one unit
                if (product.units.length == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SubscriptionPlanScreen(
                        product: product,
                        selectedUnit: product.units.first.unitName,
                      ),
                    ),
                  );
                } else {
                  _showUnitSelection(context, product);
                }
              },
            ),
          );
        },
      ),
    );
  }

  void _showUnitSelection(BuildContext context, Product product) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Unit',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...product.units.map(
              (unit) => ListTile(
                title: Text(unit.unitName),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SubscriptionPlanScreen(
                        product: product,
                        selectedUnit: unit.unitName,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
