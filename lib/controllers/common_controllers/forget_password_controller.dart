import 'package:bidcart/repository/authentication/customer_authentication_repository.dart';
import 'package:bidcart/screens/common/reset_password.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController{
  static ForgetPasswordController get instance => Get.find();

  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey=GlobalKey<FormState>();

  sendPasswordResetEmail() async{
    try{
      if(!forgetPasswordFormKey.currentState!.validate()){
        return;
      }
      await CustomerAuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());
      Get.snackbar("Email Sent ", "Email Link Sent to Reset Your Password",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green[400],
          colorText: Colors.white);
      Get.to(() => ResetPassword(email:email.text.trim()));

    } catch(e){
      Get.snackbar("Error ", "An Error Occured While Sending Mail ",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red[800],
          colorText: Colors.white);
    }
  }
  resendPasswordResetEmail(String email) async{
    try{
      await CustomerAuthenticationRepository.instance.sendPasswordResetEmail(email);
      Get.snackbar("Email Sent ", "Email Link Sent to Reset Your Password",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green[400],
          colorText: Colors.white);



    } catch(e){
      Get.snackbar("Error ", "An Error Occured While Sending Mail ",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red[800],
          colorText: Colors.white);
    }

  }
}
