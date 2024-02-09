import 'package:bidcart/model/customer_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerRepository extends GetxController {
  static CustomerRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createUser(CustomerModel user) async {
    try {
      await _db
          .collection("customer")
          .add(user.toJson());
      Get.snackbar( "Success", "Your Account Has been created.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green[400],
          colorText: Colors.white
      );
    } on Exception catch (e) {
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);


    }
  }

  getCustomer(String email) async {

    final snapshot = await _db.collection("customer").where("Email",isEqualTo: email).get();
    if (snapshot.docs.isNotEmpty) {
      final email = snapshot.docs.first.get("Email");
      print("Email: $email");
      return email;
    } else {
      print("No customer found with the provided email.");
      return "";
    }
    //final customerData = snapshot.docs.map((e) => CustomerModel.fromSnapshot(e)).single;
   // return customerData;
  }

  Future<List<CustomerModel>>getAllCustomers(String email) async {
    final snapshot = await _db.collection("customer").get();
    final customerData = snapshot.docs.map((e) => CustomerModel.fromSnapshot(e)).toList();
    return customerData;
  }

}
