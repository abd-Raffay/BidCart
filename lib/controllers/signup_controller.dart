import 'package:bidcart/model/customer_model.dart';
import 'package:bidcart/repository/authentication/authentication_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  //TextFeild Controllers

  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final phone = TextEditingController();





  Future<void> createUser(CustomerModel customer) async {
    final auth = AuthenticationRepository.instance;
    await AuthenticationRepository.instance.createUserWithEmailAndPassword(customer.email, customer.password,customer);
    auth.setIntialScreen(auth.firebaseUser.value);
  }

}
