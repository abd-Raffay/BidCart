import 'package:bidcart/repository/authentication/authentication_repository.dart';
import 'package:bidcart/toast/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  static SignInController get instance => Get.find();

  //TextFeild Controllers

  final email = TextEditingController();
  final password = TextEditingController();



  void loginUser(String email, String password) {
    AuthenticationRepository.instance.loginUserWithEmailAndPassword(email, password);
  }

  Future<void> googleSignIn() async {
    try{

      final auth=AuthenticationRepository.instance;
      await auth.signInWithGoogle();
      auth.setIntialScreen(auth.firebaseUser as User?);


    }catch(e){
    }

  }

}
