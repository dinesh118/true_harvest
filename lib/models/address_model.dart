class AddressModel {
  final String name;
  final String email;
  final String phone;
  final String street;
  final String apartment;
  final String city;
  final String state;
  final String zip;
  final String country;
  final String? deliveryInstructions;

  AddressModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.street,
    required this.apartment,
    required this.city,
    required this.state,
    required this.zip,
    required this.country,
    this.deliveryInstructions,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'street': street,
      'apartment': apartment,
      'city': city,
      'state': state,
      'zip': zip,
      'country': country,
      'deliveryInstructions': deliveryInstructions,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      street: map['street'] ?? '',
      apartment: map['apartment'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      zip: map['zip'] ?? '',
      country: map['country'] ?? '',
      deliveryInstructions: map['deliveryInstructions'],
    );
  }

  String get shortAddress {
    return '$street, $city';
  }

  String get fullAddress {
    return '$street\n$city, $state $zip\n$country';
  }
}