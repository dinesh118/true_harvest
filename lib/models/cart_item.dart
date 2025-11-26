import 'package:task_new/models/product_model.dart';

class CartItem {
  final Product product;
  final String selectedUnit;
  int quantity;

  CartItem({
    required this.product,
    required this.selectedUnit,
    this.quantity = 1,
  });

  double get price =>
      product.units
          .firstWhere(
            (unit) => unit.unitName == selectedUnit,
            orElse: () => product.units.first,
          )
          .price *
      quantity;

  // Alias for totalPrice to maintain compatibility
  double get totalPrice => price;

  // Copy with method for immutability
  CartItem copyWith({Product? product, String? selectedUnit, int? quantity}) {
    return CartItem(
      product: product ?? this.product,
      selectedUnit: selectedUnit ?? this.selectedUnit,
      quantity: quantity ?? this.quantity,
    );
  }
}
