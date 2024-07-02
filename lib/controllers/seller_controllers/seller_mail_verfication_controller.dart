import 'dart:async';

import 'package:bidcart/repository/authentication/seller_authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellerMailVerificationController extends GetxController{
 late Timer _timer;

 final sellerAuthRepo=Get.put(SellerAuthenticationRepository());

  @override
   void onInit(){
    super.onInit();
    sendVerificationEmail();
    setTimerForAutoRedirect();
  }


  Future<void> sendVerificationEmail() async {
    try{
      await sellerAuthRepo.sendEmailVerification();

    }catch (e){

      Get.snackbar( "Failed", e.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red[800],
          colorText: Colors.white
      );
      print("Error from catch send verfication ${e.toString()}");
    }
  }

  Future<void> setTimerForAutoRedirect() async{
    _timer=Timer.periodic(const Duration(seconds: 5), (timer) {
      FirebaseAuth.instance.currentUser?.reload();
      final user=FirebaseAuth.instance.currentUser;
      if(user!.emailVerified){
        timer.cancel();
        sellerAuthRepo.setInitialScreen(user);

      }
    });
  }

  Future<void> manuallyCheckEmailVerificationStatus() async{
    FirebaseAuth.instance.currentUser?.reload();
    final user=FirebaseAuth.instance.currentUser;
    if(user!.emailVerified){
      sellerAuthRepo.setInitialScreen(user);
    }
  }

}