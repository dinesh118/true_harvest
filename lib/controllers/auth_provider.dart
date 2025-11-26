// lib/controllers/auth_provider.dart
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:task_new/services/auth_service.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider();
});

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  String mobile = "";
  int timer = 30;
  bool _isLoading = false;
  String? _verificationId;

  bool get isLoading => _isLoading;
  String? get verificationId => _verificationId;

  void updateMobile(String value) {
    mobile = value;
    notifyListeners();
  }

  Future<bool> sendOTP(String phoneNumber) async {
    _isLoading = true;
    notifyListeners();

    final completer = Completer<bool>();

    try {
      await _authService.sendOTP(
        phoneNumber: phoneNumber,
        codeSent: (verificationId, resendToken) {
          _verificationId = verificationId;
          startTimer();
          _isLoading = false;
          completer.complete(true); // 🔥 Return TRUE instantly when OTP is sent
        },
        verificationFailed: (FirebaseAuthException e) {
          _isLoading = false;
          completer.completeError(e);
        },
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _authService.signInWithCredential(credential);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );

      return completer.future; // 🔥 Wait for codeSent()
    } finally {
      // _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> verifyOTP(String otp) async {
    if (_verificationId == null) {
      throw Exception('Verification ID is null. Please request a new OTP.');
    }

    _isLoading = true;
    notifyListeners();

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );
      await _authService.signInWithCredential(credential);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void startTimer() {
    timer = 30;
    notifyListeners();

    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (timer == 0) return false;
      timer--;
      notifyListeners();
      return true;
    });
  }

  void resendOtp() {
    if (mobile.isNotEmpty) {
      sendOTP('+91$mobile');
    }
  }
}
