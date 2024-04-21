import 'package:bidcart/model/customer_model.dart';
import 'package:bidcart/repository/authentication/customer_authentication_repository.dart';
import 'package:bidcart/repository/authentication/seller_authentication_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CustomerSignUpController extends GetxController {
  static CustomerSignUpController get instance => Get.find();

  final customerAuthRepo = Get.put(CustomerAuthenticationRepository());

  //TextFeild Controllers
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final phone = TextEditingController();





  Future<void> createUser(CustomerModel customer,String password) async {
    await customerAuthRepo.createUserWithEmailAndPassword(customer.email, password,customer);
    customerAuthRepo.setIntialScreen(customerAuthRepo.firebaseUser.value);
  }

}
