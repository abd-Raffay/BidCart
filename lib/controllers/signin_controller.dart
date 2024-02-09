import 'package:bidcart/repository/authentication/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  static SignInController get instance => Get.find();

  late final Rx<User?> firebaseUser;

  //TextFeild Controllers


  final email = TextEditingController();
  final password = TextEditingController();



  Future<void> loginUser (String email, String password) async {


    final auth = AuthenticationRepository.instance;
    await AuthenticationRepository.instance.loginUserWithEmailAndPassword(email, password);
    auth.setIntialScreen(auth.firebaseUser.value);



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
