// lib/screens/each_item_view.dart
import 'package:flutter/material.dart';
import 'package:task_new/models/product_model.dart';
import 'package:task_new/screens/cart_screen.dart';
import 'package:task_new/utils/app_colors.dart';
import 'package:task_new/widgets/quantity_handler.dart';

class EachItemView extends StatefulWidget {
  final Product product;
  const EachItemView({super.key, required this.product});

  @override
  State<EachItemView> createState() => _EachItemViewState();
}

class _EachItemViewState extends State<EachItemView> {
  int quantity = 1;
  final ScrollController _scrollController = ScrollController();
  // bool _showTitle = false;
  int selectedUnitIndex = 0;

  @override
  void initState() {
    super.initState();
    // _scrollController.addListener(_onScroll);
  }

  // void _onScroll() {
  //   if (_scrollController.offset > 100 && !_showTitle) {
  //     setState(() => _showTitle = true);
  //   } else if (_scrollController.offset <= 100 && _showTitle) {
  //     setState(() => _showTitle = false);
  //   }
  // }

  @override
  void dispose() {
    // _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.black54,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.black54,
                  child: IconButton(
                    icon: const Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // TODO: Add to favorites
                    },
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Hero(
                tag: 'product-${widget.product.id}',
                child: Image.asset(widget.product.imageUrl, fit: BoxFit.cover),
              ),
              title: Text(''),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name and Price
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.product.category,
                        style: const TextStyle(
                          fontSize: 24,
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.product.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),

                      Text(
                        '₹${widget.product.units[selectedUnitIndex].price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Available Units",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Wrap(
                        spacing: 10,
                        children: List.generate(widget.product.units.length, (
                          index,
                        ) {
                          final unit = widget.product.units[index];

                          final isSelected = selectedUnitIndex == index;

                          return ChoiceChip(
                            label: Text(
                              unit.unitName,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : AppColors.darkGreen,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            selected: isSelected,
                            selectedColor: AppColors.darkGreen,
                            backgroundColor: Colors.grey.shade200,
                            onSelected: (_) {
                              setState(() {
                                selectedUnitIndex = index;
                              });
                            },
                          );
                        }),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Quantity Selector
                  const Text(
                    'Quantity',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  // QuantityHandler(
                  //   quantity: quantity,
                  //   onChanged: (newQuantity) {
                  //     setState(() => quantity = newQuantity);
                  //   },
                  // ),
                  const SizedBox(height: 25),

                  // Description
                  const Text(
                    'Description',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.product.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // DESCRIPTION
                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.product.description,
                    style: TextStyle(fontSize: 15, color: Colors.grey[800]),
                  ),

                  const SizedBox(height: 25),

                  // FEATURES
                  const Text(
                    "Features",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  ...widget.product.features.map(
                    (f) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.circle,
                            size: 10,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            f,
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.darkGreen,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Add to Cart Button
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: Add to cart functionality
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.shopping_cart_outlined),
                label: const Text('Add to Cart'),
              ),
            ),
            const SizedBox(width: 16),
            // Buy Now Button
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement buy now functionality
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: AppColors.darkGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Buy Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
