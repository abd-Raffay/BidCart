import 'package:bidcart/model/customer_model.dart';
import 'package:bidcart/repository/authentication/authentication_repository.dart';
import 'package:bidcart/repository/customer_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  //TextFeild Controllers

  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final phone = TextEditingController();

  final customerrepo=Get.put(CustomerRepository());

  void registerUser(String email, String password) {
  AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password);
  }
  Future<void> createUser(CustomerModel customer) async {
    await customerrepo.createUser(customer);
    SignUpController.instance.registerUser(customer.email, customer.password);

  }

}
