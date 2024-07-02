import 'package:bidcart/model/seller_model.dart';
import 'package:bidcart/repository/authentication/seller_authentication_repository.dart';
import 'package:bidcart/repository/seller_repository/seller_login_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class SellerSignUpController extends GetxController {
  static SellerSignUpController get instance => Get.find();
 final sellerAuthRepo=Get.put(SellerAuthenticationRepository());
 final sellerReop=Get.put(SellerLoginRepository());


  //TextFeild Controllers
  final email = TextEditingController();
  final password = TextEditingController();
  final sellername = TextEditingController();
  final phone = TextEditingController();
  final storename=TextEditingController();
  final address=TextEditingController();
  final cnic=TextEditingController();

late LatLng location;

  Future<void> createUser(SellerModel seller,String password) async {
    print("Creating User ${seller}");
    await sellerAuthRepo.createTempUserWithEmailAndPassword(seller.email, password,seller);
   sellerAuthRepo.setInitialScreen(sellerAuthRepo.firebaseUser.value);
  }

  setLocation(String? sellerid,GeoPoint newLocation){
    sellerReop.updateSellerLocation(sellerid!, newLocation);
    print("Location isss ${location}");
  }




}
