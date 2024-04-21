import 'package:bidcart/model/seller_model.dart';
import 'package:bidcart/repository/authentication/seller_authentication_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class SellerSignUpController extends GetxController {
  static SellerSignUpController get instance => Get.find();
 final sellerAuthRepo=Get.put(SellerAuthenticationRepository());



  //TextFeild Controllers
  final email = TextEditingController();
  final password = TextEditingController();
  final sellername = TextEditingController();
  final phone = TextEditingController();
  final storename=TextEditingController();
  final address=TextEditingController();
  final cnic=TextEditingController();




  Future<void> createUser(SellerModel seller,String password) async {
    print("*********************************************************Seller signup controller*********************************************************************");

    await sellerAuthRepo.createUserWithEmailAndPassword(seller.email, password,seller);
   sellerAuthRepo.setInitialScreen(sellerAuthRepo.firebaseUser.value);

      print("*************************SellerAuthenticationRepository.instance**********************");



  }

}
