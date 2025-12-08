import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:task_new/models/address_model.dart';

final addressProvider = ChangeNotifierProvider<AddressController>(
  (ref) => AddressController(),
);

class AddressController extends ChangeNotifier {
  AddressModel? _address;

  AddressModel? get address => _address;

  void updateAddress(AddressModel newAddress) {
    _address = newAddress;
    notifyListeners();
  }

  void clearAddress() {
    _address = null;
    notifyListeners();
  }

  bool get hasAddress => _address != null;

  String get addressSummary {
    if (_address == null) return 'No address saved';
    return _address!.shortAddress;
  }
}
