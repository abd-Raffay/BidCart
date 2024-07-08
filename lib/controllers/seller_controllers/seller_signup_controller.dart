import 'dart:ffi';

import 'package:bidcart/model/location.dart' ;
import 'package:bidcart/model/seller_model.dart';
import 'package:bidcart/repository/authentication/seller_authentication_repository.dart';
import 'package:bidcart/repository/seller_repository/seller_login_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class SellerSignUpController extends GetxController {
  static SellerSignUpController get instance => Get.find();
 final sellerAuthRepo=Get.put(SellerAuthenticationRepository());
 final sellerRepo=Get.put(SellerLoginRepository());


  //TextFeild Controllers
  final email = TextEditingController();
  final password = TextEditingController();
  final sellername = TextEditingController();
  final phone = TextEditingController();
  final storename=TextEditingController();
  final address=TextEditingController();
  final cnic=TextEditingController();
  final location=TextEditingController();


 GeoPoint sellerlocation = GeoPoint(0, 0);




  Future<void> createUser(SellerModel seller,String password) async {
    print("Creating User ${seller}");
    await sellerAuthRepo.createTempUserWithEmailAndPassword(seller.email, password,seller);
   sellerAuthRepo.setInitialScreen(sellerAuthRepo.firebaseUser.value);
  }

  setLocation(String? sellerid,GeoPoint newLocation){
    sellerRepo.updateSellerLocation(sellerid!, newLocation);

  }

  Future<void> saveLocation(GeoPoint location) async {
    try {

      final _auth = FirebaseAuth.instance;
      String? sellerId = _auth.currentUser?.uid;

      SellerModel seller = await sellerRepo.getSellerData(sellerId!);



      Locations temp = Locations(
        locationid: "", // Firestore will auto-generate this
        location: location,
        sellerid: sellerId,
        storename: seller.storename,
      );

      await sellerRepo.saveLocation(temp,sellerId);
    } catch (e) {
      print("Error saving location: $e");
      // Handle error as needed, e.g., show an error message to the user
      throw e; // Re-throwing the error for handling in UI or other layers
    }
  }

  getLocations() async {
    return  sellerRepo.getAllLocations();
  }

  setLocationSignup(GeoPoint location) async {
   sellerlocation=GeoPoint(location.latitude, location.longitude);
   await setAddress(sellerlocation);
  }

  setAddress(GeoPoint position) async {
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude,position.longitude);
      address.text = '${placemarks[0].subLocality}, ${placemarks[0].locality}';
  }




}
