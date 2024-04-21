import 'package:bidcart/model/customer_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerRepository extends GetxController {
  static CustomerRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  late CustomerModel customer;


  @override
  void onInit() {
    super.onInit();
    // Call main function to initialize orderRequests list
  }




  createUser(CustomerModel user) async {
    try {
      await _db
          .collection("customer")
          .add(user.toJson()).whenComplete(() => Get.snackbar( "Success", "Please Verify your Email.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green[400],
          colorText: Colors.white
      ));

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
      //print("Email: $email");
      customer=(await getCustomerr(email))!;
      return email;
    } else {
      //print("No customer found with the provided email.");
      return "";
    }
  }


  Future<CustomerModel?> getCustomerr(String email) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("customer")
        .where("Email", isEqualTo: email)
        .get();

    if (snapshot.docs.isNotEmpty) {
      // If document exists, create a CustomerModel instance from it
      return CustomerModel.fromSnapshot(snapshot.docs.first);
    } else {
      return null; // Return null if no user found with the provided email
    }
  }
}
