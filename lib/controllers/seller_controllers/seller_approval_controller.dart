import 'dart:async';
import 'package:bidcart/repository/authentication/seller_authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellerApprovalController extends GetxController {
  late Timer _timer;

  @override
  void onInit() {
    super.onInit();
    //setTimerForAutoRedirect();
  }


  Future<void> setTimerForAutoRedirect() async {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user!.emailVerified) {
        timer.cancel();
        SellerAuthenticationRepository.instance.setInitialScreen(user);
      }
    });
  }

  Future<void> manuallyCheckStoreVerificationStatus() async {
    String status =
    await SellerAuthenticationRepository.instance.GetApprovalStatus();
    final user = FirebaseAuth.instance.currentUser;

    if (status == "approved") {
      SellerAuthenticationRepository.instance.setInitialScreen(user);
    }
    if (status == "rejected") {
      SellerAuthenticationRepository.instance.setInitialScreen(user);
    }
  }

  Future<void> Logout() async {
    await SellerAuthenticationRepository.instance.logout();
  }
}
