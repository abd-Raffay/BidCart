import 'package:bidcart/model/seller_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/review_model.dart';

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

  Stream<List<Review>> getReviews() {
    final CollectionReference reviewsCollection = FirebaseFirestore.instance.collection('reviews');
    final Stream<QuerySnapshot> reviewsSnapshots = reviewsCollection.snapshots();

    return reviewsSnapshots.map((snapshot) {
      List<Review> reviews = [];

      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>?;
        print('Document data: $data');
        print('Document ID: ${doc.id}');
        try {
          if (data != null) {
            Review review = Review.fromSnapshot(doc as DocumentSnapshot<Map<String, dynamic>>);
            reviews.add(review);
            print('Converted review: ${review.toJson()}');
          } else {
            print('Document data is null.');
          }
        } catch (e) {
          print('Error converting document to Review: $e');
          if (data != null) {
            // Print detailed information about each field to identify the problematic one
            print('Fields in document:');
            data.forEach((key, value) {
              print('$key: $value');
            });
          }
        }
      }

      // Sort reviews by reviewDateTime
      reviews.sort((a, b) => a.reviewDateTime.compareTo(b.reviewDateTime));

      print('Sorted Reviews list: ${reviews.map((e) => e.toJson()).toList()}');
      return reviews;
    }).handleError((error) {
      print('Error retrieving reviews from Firestore: $error');
      return [];
    });
  }




}





