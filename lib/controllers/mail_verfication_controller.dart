import 'dart:async';

import 'package:bidcart/repository/authentication/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class MailVerificationController extends GetxController{
 late Timer _timer;

  @override
  void onInit(){
    super.onInit();
    sendVerificationEmail();
    setTimerForAutoRedirect();
  }


  Future<void> sendVerificationEmail() async {
    try{
      await AuthenticationRepository.instance.sendEmailVerification();

    }catch (e){
      //snackbar
      print("Error from catch send verfication ${e.toString()}");
    }

  }

  Future<void> setTimerForAutoRedirect() async{
    _timer=Timer.periodic(const Duration(seconds: 3), (timer) {
      FirebaseAuth.instance.currentUser?.reload();
      final user=FirebaseAuth.instance.currentUser;
      if(user!.emailVerified){
        timer.cancel();
        AuthenticationRepository.instance.setIntialScreen(user);

      }
    });
  }

  Future<void> manuallyCheckEmailVerificationStatus() async{
    FirebaseAuth.instance.currentUser?.reload();
    final user=FirebaseAuth.instance.currentUser;
    if(user!.emailVerified){
      AuthenticationRepository.instance.setIntialScreen(user);
    }



  }

}