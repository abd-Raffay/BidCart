import 'package:bidcart/repository/authentication/seller_authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class SellerLogInController extends GetxController {
  static SellerLogInController get instance => Get.find();

  late final Rx<User?> firebaseUser;

  //TextFeild Controllers


  final email = TextEditingController();
  final password = TextEditingController();



  Future<void> loginUser (String email, String password) async {

    Get.put(SellerAuthenticationRepository());
    final auth = SellerAuthenticationRepository.instance;
    await SellerAuthenticationRepository.instance.loginUserWithEmailAndPassword(email, password);
    auth.setInitialScreen(auth.firebaseUser.value);

  }


}
