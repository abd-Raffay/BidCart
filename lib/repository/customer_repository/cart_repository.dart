import 'package:bidcart/model/cart_model.dart';
import 'package:bidcart/repository/customer_repository/customer_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
          'dateTime':combinedDateTime
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




}