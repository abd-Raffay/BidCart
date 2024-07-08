import 'dart:async';
import 'package:bidcart/repository/authentication/seller_authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SellerApprovalController extends GetxController {
  SellerApprovalController get instance => Get.find();
  late Timer _timer;

  final sellerAuthRepo=Get.put(SellerAuthenticationRepository());

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
        sellerAuthRepo.setInitialScreen(user);
      }
    });
  }

  Future<void> manuallyCheckStoreVerificationStatus() async {
    String status =
    await sellerAuthRepo.GetApprovalStatus();
    final user = FirebaseAuth.instance.currentUser;

    if (status == "approved") {
      sellerAuthRepo.setInitialScreen(user);
    }
    if (status == "rejected") {
      sellerAuthRepo.setInitialScreen(user);
    }
  }

  Future<void> Logout() async {
    await sellerAuthRepo.logout();
  }
}
