import 'package:bidcart/repository/authentication/customer_authentication_repository.dart';
import 'package:bidcart/screens/admin/admin_navigationbar.dart';
import 'package:bidcart/screens/common/onboarding.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerSignInController extends GetxController {
  static CustomerSignInController get instance => Get.find();

  late final Rx<User?> firebaseUser;

  //TextFeild Controllers

  final email = TextEditingController();
  final password = TextEditingController();
  final customerAuthRepo = Get.put(CustomerAuthenticationRepository());

  Future<void> loginUser(String email, String password) async {
    print("Email = ${email} && password = ${password}");
    if (email == "admin@gmail.com" && password == "admin") {
      Get.offAll(() => const AdminNavigationBar());
    } else {
      bool status =
          await customerAuthRepo.loginUserWithEmailAndPassword(email, password);
      print(
          "Statusssssssssssssssssssssssssssss isssssssssssssssssssss ${status}");
      if (status == true) {
        print(
            "Statusssssssssssssssssssssssssssss isssssssssssssssssssss trueeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
        customerAuthRepo.setIntialScreen(
          customerAuthRepo.firebaseUser.value,
        );
      }
    }
  }

  void Logout() {
    customerAuthRepo.logout();
    Get.offAll(() => const OnBoarding());
  }
}
