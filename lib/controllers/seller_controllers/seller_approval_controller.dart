import 'dart:async';
import 'package:bidcart/repository/authentication/seller_authentication_repository.dart';
import 'package:bidcart/repository/seller_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellerApprovalController extends GetxController{
  late Timer _timer;

  @override
  void onInit(){
    super.onInit();
    sendVerificationEmail();
    setTimerForAutoRedirect();
  }


  Future<void> sendVerificationEmail() async {
    try{

      //await SellerAuthenticationRepository.instance.sendEmailVerification();

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
        SellerAuthenticationRepository.instance.setInitialScreen(user);

      }
    });
  }

  Future<void> manuallyCheckStoreVerificationStatus() async{

    Future status=await SellerAuthenticationRepository.instance.GetApprovalStatus();
    final user=FirebaseAuth.instance.currentUser;

    if(status=="approved"){
      SellerAuthenticationRepository.instance.setInitialScreen(user);
    }




    //FirebaseAuth.instance.currentUser?.reload();
    //final user=FirebaseAuth.instance.currentUser;
    //if(user!.emailVerified){
     // SellerAuthenticationRepository.instance.setInitialScreen(user);
   // }
  }

}