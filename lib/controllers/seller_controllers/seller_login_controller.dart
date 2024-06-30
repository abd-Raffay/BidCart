import 'package:bidcart/repository/authentication/seller_authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellerLogInController extends GetxController {
  static SellerLogInController get instance => Get.find();

  final sellerAuthRepo = Get.put(SellerAuthenticationRepository());

  late final Rx<User?> firebaseUser;

  //TextFeild Controllers

  final email = TextEditingController();
  final password = TextEditingController();

  Future<void> loginUser(String email, String password,) async {

    bool status =
        await sellerAuthRepo.loginUserWithEmailAndPassword(email, password);
    if (status == true) {
      sellerAuthRepo.setInitialScreen(sellerAuthRepo.firebaseUser.value,);


    }

  }
}
