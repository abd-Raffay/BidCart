import 'package:bidcart/model/seller_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminRepository extends GetxController{
  static AdminRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Stream<List<SellerModel>> getSellers() {
    try {
      return _db.collection("seller").snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          if (doc.exists) {
            return SellerModel.fromSnapshot(doc);
          } else {
            // Handle the case where the document does not exist
            return null;
          }
        }).where((seller) => seller != null).map((seller) => seller as SellerModel).toList();
      });
    } catch (e) {
      print("Error getting sellers: $e");
      return Stream.value([]);
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





