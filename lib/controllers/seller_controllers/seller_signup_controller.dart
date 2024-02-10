import 'package:bidcart/model/seller_model.dart';
import 'package:bidcart/repository/authentication/seller_authentication_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class SellerSignUpController extends GetxController {
  static SellerSignUpController get instance => Get.find();




  //TextFeild Controllers
  final email = TextEditingController();
  final password = TextEditingController();
  final sellername = TextEditingController();
  final phone = TextEditingController();
  final storename=TextEditingController();
  final address=TextEditingController();
  final cnic=TextEditingController();




  Future<void> createUser(SellerModel seller) async {
    print("*********************************************************Seller signup controller*********************************************************************");
    Get.put(SellerAuthenticationRepository());
    final auth = SellerAuthenticationRepository.instance;
    await auth.createUserWithEmailAndPassword(seller.email, seller.password,seller);
    auth.setInitialScreen(auth.firebaseUser.value);

      print("*************************SellerAuthenticationRepository.instance**********************");



  }

}
