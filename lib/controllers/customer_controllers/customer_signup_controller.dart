

import 'package:bidcart/model/customer_model.dart';
import 'package:bidcart/repository/authentication/customer_authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class CustomerSignUpController extends GetxController {
  static CustomerSignUpController get instance => Get.find();

  final customerAuthRepo = Get.put(CustomerAuthenticationRepository());

  //TextFeild Controllers
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final phone = TextEditingController();
 late final address = TextEditingController();
   GeoPoint location= GeoPoint(0, 0);

  late Position position;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCurrentLocation();
  }

  void getCurrentLocation() async {
    position = await deteminePosition();
    location = GeoPoint(position.latitude, position.longitude);
  }

  Future<Position> deteminePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permissions are denied');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  void convertLocation(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude,position.longitude);
    address.text = '${placemarks[0].subLocality}, ${placemarks[0].locality}';
    
  }




  Future<void> createUser(CustomerModel customer, String password) async {
    await customerAuthRepo.createUserWithEmailAndPassword(
        customer.email, password, customer);
    customerAuthRepo.setIntialScreen(customerAuthRepo.firebaseUser.value);
  }




}
