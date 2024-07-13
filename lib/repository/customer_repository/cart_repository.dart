import 'package:bidcart/model/cart_model.dart';
import 'package:bidcart/model/offer_model.dart';
import 'package:bidcart/model/request_model.dart';
import 'package:bidcart/repository/customer_repository/customer_repository.dart';
import 'package:bidcart/screens/customer/customer_orderscreen.dart';
import 'package:bidcart/widget/snackbar/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../model/review_model.dart';
import '../../model/review_model.dart';


class CartRepository extends GetxController{
  static CartRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  late final Rx<User?> firebaseUser;
  final _auth = FirebaseAuth.instance;

  final customerRepo=Get.put(CustomerRepository());

  Future<void> saveOrderRequest(RxList<CartModel> items,GeoPoint location,int distance) async {
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
          'sellerId':"null",
          'location':location,
          'distance':distance,
          'price':0,
          'sellerLocation':GeoPoint(0,0)
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

  Future<void> generateNewRequest(RequestData request) async {
    try {
      final CollectionReference orderRequestCollection = _db.collection('orderrequest');

      // Access the current user's ID
      final String? userId = _auth.currentUser?.uid;

      final DateTime now = DateTime.now();
      final String combinedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
      final List<Map<String, dynamic>> itemsData = request.items.map((item) => item.toJson()).toList();
      if (userId != null) {

          await orderRequestCollection.add({
            'customerName':request.customerName,
            'customerid': request.customerId,
            'items': itemsData,
            'dateTime':combinedDateTime,
            'status':"null",
            'sellerId':"null",
            'location':request.location,
            'distance':request.distance,
            'price':0,
            'sellerLocation':GeoPoint(0,0)
            // You can add other fields to the document if needed
          });

          Get.offAll(() => const CustomerOrderScreen());


      } else {
        print('User not authenticated.');
        // Handle the case where the user is not authenticated
      }
    } catch (e) {
      // Handle errors
      print('Error saving New order request: $e');
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

          try {
            OfferData offer = OfferData.fromSnapshot(doc);
            offers.add(offer);

          } catch (e) {

            // Print detailed information about each field to identify the problematic one

            doc.data().forEach((key, value) {

            });
          }
        }

        return offers;
      });
    } catch (e) {
      print('Error retrieving offers from Firestore: $e');
      return Stream.value([]); // Return an empty stream indicating failure
    }
  }

  Future<void> acceptOrder(String sellerId, String orderId,int price,GeoPoint sellerLocation) async {
    try {
      // Get a reference to the specific order document in the Firestore collection
      DocumentReference orderRef = FirebaseFirestore.instance.collection('orderrequest').doc(orderId);

      // Define the fields you want to update
      Map<String, dynamic> updatedFields = {
        'status': 'accepted',
        'sellerId': sellerId,
        'price':price,
        'sellerLocation':sellerLocation
        // Add any other fields you want to update here
      };


      // Update the document with the new fields
      await orderRef.update(updatedFields);

      final CollectionReference inventoryCollection = _db.collection('selleroffers');
      final DocumentReference sellerDocRef = inventoryCollection.doc(sellerId);
      final CollectionReference productsCollection = sellerDocRef.collection('offers');

      // Update the specific product document
      await productsCollection.doc(orderId).update({
        'status': "accepted",
        // Add other fields to update here if necessary
      });

      print('Order accepted successfully.');


    } catch (e) {

      print('Error accepting order: $e');
    }
  }

  Future<void> updateDistance(int distance, String orderId) async {
    try {
      // Get a reference to the specific order document in the Firestore collection
      DocumentReference orderRef = FirebaseFirestore.instance.collection('orderrequest').doc(orderId);

      // Define the fields you want to update
      Map<String, dynamic> updatedFields = {
        'distance': distance,
      };

      // Update the document with the new fields
      await orderRef.update(updatedFields);

      print('Distance updated successfully.');
      Get.back(); // Close the dialog or navigate back

    } catch (e) {

      print('Error updating distance: $e');
    }
  }




  Future<void> saveReview(Review review) async {
    try {

      final CollectionReference reviewCollection = FirebaseFirestore.instance.collection('reviews');

      final DateTime now = DateTime.now();
      final String combinedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

      // Convert review to a Map
      Map<String, dynamic> reviewData = {
        'customerId': review.customerId,
        'offer': review.offer.toJson(), // Convert OfferData to JSON format
        'reviewDateTime': combinedDateTime,
        'review': review.review,
        'customerName': review.customerName,
      };

      // Add review data to Firestore
      await reviewCollection.add(reviewData);

      DocumentReference orderRef = FirebaseFirestore.instance.collection('orderrequest').doc(review.offer.orderId);
      Map<String, dynamic> updatedFields = {
        'status': 'reviewed',
        // Add any other fields you want to update here
      };
      await orderRef.update(updatedFields);
      print('Review saved successfully');



    } catch (e) {
      // Handle errors
      print('Error saving review: $e');
    }
  }

  Future<void> completeOrder(String orderId,String sellerId) async {
    try {

      DocumentReference orderRef = FirebaseFirestore.instance.collection('orderrequest').doc(orderId);
      Map<String, dynamic> updatedFields = {
        'status': 'completed',
        // Add any other fields you want to update here
      };
      await orderRef.update(updatedFields);
      final CollectionReference inventoryCollection = _db.collection('selleroffers');
      final DocumentReference sellerDocRef = inventoryCollection.doc(sellerId);
      final CollectionReference productsCollection = sellerDocRef.collection('offers');

      // Update the specific product document
      await productsCollection.doc(orderId).update({
        'status': "completed",
        // Add other fields to update here if necessary
      });


      print('Review saved successfully');

    } catch (e) {
      // Handle errors
      print('Error saving review: $e');
    }
  }









}