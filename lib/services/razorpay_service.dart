import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPayService {
  late Razorpay _razorpay;

  final VoidCallback? onPaymentOpen;
  final VoidCallback? onPaymentSuccess;
  final VoidCallback? onPaymentFailed;
  final VoidCallback? onPaymentClose;

  RazorPayService({
    this.onPaymentOpen,
    this.onPaymentSuccess,
    this.onPaymentFailed,
    this.onPaymentClose,
  }) {
    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handleSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handleError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleWallet);

    // Razorpay added a "close" event in newer versions
    _razorpay.on("RZP_PAYMENT_LINK_CLOSED", _handleClose);
  }

  void openPayment({
    required double amount,
    String? customerName,
    String? customerEmail,
    String? customerPhone,
    String? description,
  }) {
    debugPrint('RazorPay Service: Opening payment for amount: ₹$amount');
    
    // Tell UI that payment window is opening
    onPaymentOpen?.call();

    var options = {
      'key': 'rzp_test_ChtIh4impxVRVG', // Your test key
      'amount': (amount * 100).toInt(), // Convert to paise
      'name': 'True Harvest',
      'description': description ?? 'Fresh Organic Products',
      'prefill': {
        'contact': customerPhone ?? '9876543210',
        'email': customerEmail ?? 'customer@trueharvest.com',
      },
      'theme': {
        'color': '#2E7D32', // Your app's green color
      },
    };

    debugPrint('RazorPay Options: $options');

    try {
      debugPrint('Calling _razorpay.open()...');
      _razorpay.open(options);
      debugPrint('Razorpay.open() called successfully');
    } catch (e) {
      debugPrint('Error opening Razorpay: $e');
      onPaymentFailed?.call();
    }
  }

  void dispose() {
    _razorpay.clear();
  }

  void _handleSuccess(PaymentSuccessResponse response) {
    debugPrint('Payment Success: ${response.paymentId}');
    onPaymentSuccess?.call();
  }

  void _handleError(PaymentFailureResponse response) {
    debugPrint('Payment Error: ${response.code} - ${response.message}');
    onPaymentFailed?.call();
  }

  void _handleWallet(ExternalWalletResponse response) {
    debugPrint("External Wallet: ${response.walletName}");
  }

  void _handleClose(dynamic _) {
    debugPrint("Payment window closed");
    onPaymentClose?.call();
  }
}
