import 'package:bidcart/model/cart_model.dart';
import 'package:bidcart/model/offer_model.dart';
import 'package:bidcart/repository/customer_repository/customer_repository.dart';
import 'package:bidcart/widget/snackbar/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


class CartRepository extends GetxController{
  static CartRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  late final Rx<User?> firebaseUser;
  final _auth = FirebaseAuth.instance;

  final customerRepo=Get.put(CustomerRepository());

  Future<void> saveOrderRequest(RxList<CartModel> items) async {
    try {
      final CollectionReference orderRequestCollection = _db.collection('orderrequest');

      // Convert list of CartModel items to a list of JSON data
      final List<Map<String, dynamic>> itemsData = items.map((item) => item.toJson()).toList();

      // Access the current user's ID
      final String? userId = _auth.currentUser?.uid;

      final DateTime now = DateTime.now();
      final String combinedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);



      // Check if the user is authenticated
      if (userId != null) {
        await orderRequestCollection.add({
          'customerName':customerRepo.customer.name,
          'customerid': userId,
          'items': itemsData,
          'dateTime':combinedDateTime,
          'status':"null",
          'sellerId':"null"
          // You can add other fields to the document if needed
        });

        // Clear the cart after saving order request
        // Show success message or perform any other actions
      } else {
        print('User not authenticated.');
        // Handle the case where the user is not authenticated
      }
    } catch (e) {
      // Handle errors
      print('Error saving order request: $e');
    }
  }

  Stream<List<OfferData>> getOffersByOrderId(String orderId) {
    try {
      final CollectionReference offersCollection = FirebaseFirestore.instance
          .collection('offers');
      final Stream<
          QuerySnapshot<Map<String, dynamic>>> offerSnapshots = offersCollection
          .doc(orderId).collection('offers').snapshots();

      return offerSnapshots.map((snapshot) {
        List<OfferData> offers = [];

        for (var doc in snapshot.docs) {
          print('Document data: ${doc.data()}');
          print('Document ID: ${doc.id}');
          try {
            OfferData offer = OfferData.fromSnapshot(doc);
            offers.add(offer);
            print('Converted offer: ${offer.toJson()}');
          } catch (e) {
            print('Error converting document to OfferData: $e');
            // Print detailed information about each field to identify the problematic one
            print('Fields in document:');
            doc.data().forEach((key, value) {
              print('$key: $value');
            });
          }
        }

        print('Offers retrieved for orderId: $orderId');
        print('Offers list: ${offers.map((e) => e.toJson()).toList()}');
        if (offers.isEmpty) {
          showSnackbar(
            title: "Offer Not Found!",
            message: "No Offers were placed on this order.",
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        }

        return offers;
      });
    } catch (e) {
      print('Error retrieving offers from Firestore: $e');

      // Show error snackbar (ensure showSnackbar is defined)
      showSnackbar(
        title: "Error",
        message: "Failed to retrieve offers.",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );

      return Stream.value([]); // Return an empty stream indicating failure
    }
  }

  Future<void> acceptOrder(String sellerId, String orderId) async {
    try {
      // Get a reference to the specific order document in the Firestore collection
      DocumentReference orderRef = FirebaseFirestore.instance.collection('orderrequest').doc(orderId);

      // Define the fields you want to update
      Map<String, dynamic> updatedFields = {
        'status': 'accepted',
        'sellerId': sellerId,
        // Add any other fields you want to update here
      };

      // Update the document with the new fields
      await orderRef.update(updatedFields);

      print('Order accepted successfully.');
      Get.back();
      showSnackbar(title: "Success", message: "Order has been Places Successfully", backgroundColor: Colors.green);

    } catch (e) {
      showSnackbar(title: "Failed ", message: "Error accepting order: $e", backgroundColor: Colors.red);
      print('Error accepting order: $e');
    }
  }





}