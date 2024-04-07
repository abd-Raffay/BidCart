import 'package:bidcart/model/seller_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminRepository extends GetxController{
  static AdminRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<SellerModel>> getSeller() async {
    try {
      final snapshot = await _db.collection("seller").get();

      List<SellerModel> sellerList = [];

      for (var doc in snapshot.docs) {
        if (doc.exists) {
          SellerModel seller = SellerModel.fromSnapshot(doc);
          sellerList.add(seller);
        }
      }
      return sellerList;
    } catch (e) {

      print("Error getting sellers: $e");
      return [];
    }
  }

  Future<void> setStatus(String sellerId, String status) async {
    try {

      final DocumentReference sellerRef = _db.collection('seller').doc(sellerId);
      await sellerRef.update({'Status': status});
      print('Status updated successfully for seller $sellerId');
      Get.snackbar("Success", "Status updated successfully for seller ",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.cyan.withOpacity(0.1),
        duration: const Duration(milliseconds: 900),
        colorText: Colors.cyan,
      );
    } catch (e) {

      Get.snackbar("Failed", "Error updating status for seller",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(0.1),
        duration: const Duration(milliseconds: 900),
        colorText: Colors.white,
      );

      rethrow;
    }
  }

}





