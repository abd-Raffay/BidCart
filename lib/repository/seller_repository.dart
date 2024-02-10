import 'package:bidcart/model/seller_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class SellerRepository extends GetxController{
  static SellerRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  createUser(SellerModel user) async {
    try {
      await _db
          .collection("seller")
          .add(user.toJson());
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

  getSeller(String email) async {

    final snapshot = await _db.collection("seller").where("Email",isEqualTo: email).get();
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

  getApprovalStatus(String id) async {

    final snapshot = await _db.collection("seller").where("Userid",isEqualTo: id).get();
    if (snapshot.docs.isNotEmpty) {
      final approval = snapshot.docs.first.get("Status");
      //print("Email: $approval");
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

}