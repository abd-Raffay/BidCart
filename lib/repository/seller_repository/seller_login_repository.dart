import 'package:bidcart/model/location.dart';
import 'package:bidcart/model/seller_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class SellerLoginRepository extends GetxController{
  static SellerLoginRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  createtempUser(SellerModel user,String sellerid) async {
    try {
      await _db
          .collection("tempseller")
          .doc(sellerid)
          .set(user.toJson());
      /*Get.snackbar( "Please", "Your Account Has been created.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green[400],
          colorText: Colors.white
      );*/
    } on Exception catch (e) {
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);

    }
  }

  createUser(SellerModel user,String sellerid) async {
    try {
      await _db
          .collection("seller")
          .doc(sellerid)
          .set(user.toJson());
      /*Get.snackbar( "Please", "Your Account Has been created.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green[400],
          colorText: Colors.white
      );*/
    } on Exception catch (e) {
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);

    }
  }
  Future<void> updateSellerLocation(String sellerid, GeoPoint newLocation) async {
    try {
      await _db.collection("seller").doc(sellerid).update({'location': newLocation, });
      await _db.collection("tempseller").doc(sellerid).update({'location': newLocation, });


      Get.snackbar(
        "Success",
        "Location updated successfully.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green[400],
        colorText: Colors.white,
      );
    } catch (e) {

      Get.snackbar(
        "Error",
        "Failed to update location. Try again",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red,
      );
      print("Error: $e");
    }
  }

  gettempSellerEmail(String email) async {

    final snapshot = await _db.collection("tempseller").where("Email",isEqualTo: email).get();
    if (snapshot.docs.isNotEmpty) {
      final email = snapshot.docs.first.get("Email");
      //print("Email: $email");
      return email;
    } else {
      print("No Seller found with the provided email.");
      return "";
    }
    //final customerData = snapshot.docs.map((e) => CustomerModel.fromSnapshot(e)).single;
    // return customerData;
  }
  saveLocation(Location location,String sellerid) async {
    try {
      await _db
          .collection("locations")
          .doc(sellerid)
          .set(location.toJson());
      /*Get.snackbar( "Please", "Your Account Has been created.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green[400],
          colorText: Colors.white
      );*/
    } on Exception catch (e) {
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
    }

  }
  Future<List<Location>> getAllLocations() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
      await _db.collection("locations").get();

      return snapshot.docs.map((doc) => Location.fromJson(doc.data())).toList();
    } catch (e) {
      print("Error getting locations: $e");
      return [];
    }
  }

  Future<SellerModel?> gettempUser(String userid) async {
    final snapshot = await _db.collection("tempseller").doc(userid).get();

    if (snapshot.exists && snapshot.data() != null) {
      return SellerModel.fromSnapshot(snapshot);
    } else {
      print("No Seller found with the provided ID.");
      return null;
    }
  }

  getApprovalStatus(String id) async {

    final snapshot = await _db.collection("seller").where("Userid",isEqualTo: id).get();
    if (snapshot.docs.isNotEmpty) {
      final approval = snapshot.docs.first.get("Status");
      return approval;
    } else {
      print("No Seller found with the provided email.");
      return "";
    }
    //final customerData = snapshot.docs.map((e) => CustomerModel.fromSnapshot(e)).single;
    // return customerData;
  }

  Future<List<SellerModel>>getAllSeller(String email) async {
    final snapshot = await _db.collection("seller").get();
    final sellerData = snapshot.docs.map((e) => SellerModel.fromSnapshot(e)).toList();
    return sellerData;
  }


   getSellerData(String userid) async {
    try {
      print(userid);
      final snapshot = await _db.collection("tempseller").get();

      for (var doc in snapshot.docs) {
        if (doc.id == userid) {
          return SellerModel.fromSnapshot(doc);
        }
      }
    } catch (e) {
      // Handle errors
      print('Error fetching seller data: $e');
      return null;
    }
  }

  Future<bool> checkSeller(String userid) async {
    try {
      final snapshot = await _db.collection("seller").get();
      for (var doc in snapshot.docs) {
        if (doc.id == userid) {
          return true;
        }
      }
      return false;
    } catch (e) {
      // Handle errors
      print('Error fetching seller data: $e');
      return false;
    }
  }

}