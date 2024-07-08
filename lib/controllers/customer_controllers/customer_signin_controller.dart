import 'package:bidcart/model/customer_model.dart';
import 'package:bidcart/repository/authentication/customer_authentication_repository.dart';
import 'package:bidcart/repository/customer_repository/customer_repository.dart';
import 'package:bidcart/screens/admin/admin_navigationbar.dart';
import 'package:bidcart/screens/common/onboarding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerSignInController extends GetxController {
  static CustomerSignInController get instance => Get.find();

  // Rx<User?> firebaseUser;
  User? auth = FirebaseAuth.instance.currentUser;

  // Customer model with initial values

  final email = TextEditingController();
  final password = TextEditingController();

  // Dependency injection for repositories
  final customerAuthRepo = Get.put(CustomerAuthenticationRepository());
  final customerController = Get.put(CustomerRepository());


  Future<void> loginUser(String email, String password) async {
    if (email == "admin@gmail.com" && password == "admin") {
      Get.offAll(() => const AdminNavigationBar());
    } else {
      bool status = await customerAuthRepo.loginUserWithEmailAndPassword(email, password);
      if (status) {
        customerAuthRepo.setIntialScreen(
          customerAuthRepo.firebaseUser.value,
        );
      }
    }
  }



}