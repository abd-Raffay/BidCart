import 'package:bidcart/model/cart_model.dart';
import 'package:bidcart/model/offer_model.dart';
import 'package:bidcart/model/product_model.dart';
import 'package:bidcart/model/request_model.dart';
import 'package:bidcart/model/seller_inventory.dart';
import 'package:bidcart/widget/snackbar/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/review_model.dart';

class SellerStoreRepository extends GetxController {
  SellerStoreRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  late final Rx<User?> firebaseUser;
  final _auth = FirebaseAuth.instance;

  Future<List<ProductModel>> getProducts() async {
    try {
      final snapshot = await _db.collection("products").get();
      List<ProductModel> productList = [];

      snapshot.docs.forEach((doc) {
        ProductModel product = ProductModel.fromSnapshot(doc);
        productList.add(product);
      });
      return productList;
    } catch (e) {
      // Handle any errors that may occur during fetching data
      print("Error getting products: $e");
      return [];
    }
  }

  Future<void> saveToInventory(Inventory product) async {
    try {
      final CollectionReference inventoryCollection =
          _db.collection('inventory');

      // Access the current user's ID
      final String? userId = _auth.currentUser?.uid;

      // Check if the user is authenticated
      if (userId != null) {
        // Convert SellerProductModel object to JSON format
        Map<String, dynamic> productData = product.toJson();

        // Add additional fields to the document
        productData['userid'] = userId;

        // Reference to the user's document in the "inventory" collection
        final DocumentReference userDocRef = inventoryCollection.doc(userId);

        // Reference to the "products" subcollection under the user's document
        final CollectionReference productsCollection =
            userDocRef.collection('products');

        // Save the product data to a document under the "products" subcollection
        await productsCollection.add(productData);

        // Clear the cart after saving the product to inventory
        // Show success message or perform any other actions
      } else {
        print('User not authenticated.');
        // Handle the case where the user is not authenticated
      }
    } catch (e) {
      // Handle errors
      print('Error saving product to inventory: $e');

    }
  }

  Stream<List<Inventory>> getProductsFromInventory(String sellerId) {
    try {
      final CollectionReference inventoryCollection = FirebaseFirestore.instance
          .collection('inventory');
      final Stream<
          QuerySnapshot<Map<String, dynamic>>> inventorySnapshots = inventoryCollection
          .doc(sellerId).collection('products').snapshots();

      return inventorySnapshots.map((snapshot) {
        List<Inventory> inventory = [];

        for (var doc in snapshot.docs) {
          try {
            Inventory tempinventory = Inventory.fromSnapshot(doc);
            inventory.add(tempinventory);
            print('Inventory: ${tempinventory.toJson()}');
          } catch (e) {
            print('Error converting document to OfferData: $e');
            // Print detailed information about each field to identify the problematic one
            print('Fields in document:');
            doc.data().forEach((key, value) {
              print('$key: $value');
            });
          }
        }
        return inventory;
      });
    } catch (e) {
      print('Error retrieving offers from Firestore: $e');

      // Show error snackbar (ensure showSnackbar is defined)


      return Stream.value([]); // Return an empty stream indicating failure
    }
  }

  Future<List<Inventory>> getInventory(String sellerId) async {
    try {
      final CollectionReference inventoryCollection = FirebaseFirestore.instance.collection('inventory');
      final QuerySnapshot<Map<String, dynamic>> inventorySnapshot = await inventoryCollection
          .doc(sellerId)
          .collection('products')
          .get();

      List<Inventory> inventory = [];

      for (var doc in inventorySnapshot.docs) {
        try {
          Inventory tempinventory = Inventory.fromSnapshot(doc);
          inventory.add(tempinventory);
          print('Inventory: ${tempinventory.toJson()}');
        } catch (e) {
          print('Error converting document to Inventory: $e');
          // Print detailed information about each field to identify the problematic one
          print('Fields in document:');
          doc.data().forEach((key, value) {
            print('$key: $value');
          });
        }
      }
      return inventory;
    } catch (e) {
      print('Error retrieving inventory from Firestore: $e');
      return []; // Return an empty list indicating failure
    }
  }


  Future<void> updateInventory(String sellerId, String inventoryId, int quantity) async {
    try {

      final CollectionReference inventoryCollection = _db.collection('inventory');
      final DocumentReference sellerDocRef = inventoryCollection.doc(sellerId);
      final CollectionReference productsCollection = sellerDocRef.collection('products');

      // Update the specific product document
      await productsCollection.doc(inventoryId).update({
        'quantity': quantity,
        // Add other fields to update here if necessary
      });
      print('Inventory updated successfully.');
    } catch (e) {
      print('Error updating inventory: $e');
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      final CollectionReference inventoryCollection =
          FirebaseFirestore.instance.collection('inventory');

      if (_auth.currentUser?.uid != null) {
        final DocumentReference userDocRef =
            inventoryCollection.doc(_auth.currentUser?.uid);
        final CollectionReference productsCollection =
            userDocRef.collection('products');

        // Delete the document with the specified product ID
        await productsCollection.doc(productId).delete();
      } else {
        print('User not authenticated.');
      }
    } catch (e) {
      print('Error deleting product: $e');
    }
  }
  Future<void> updateProduct(String productId,int quantity) async {
    try {
      final CollectionReference inventoryCollection =
      FirebaseFirestore.instance.collection('inventory');

      if (_auth.currentUser?.uid != null) {
        final DocumentReference userDocRef =
        inventoryCollection.doc(_auth.currentUser?.uid);
        final CollectionReference productsCollection =
        userDocRef.collection('products');
        // Delete the document with the specified product ID
        await productsCollection.doc(productId).update({
          'quantity': quantity,
        });
      } else {
        print('User not authenticated.');
      }
    } catch (e) {
      print('Error updating product: $e');
    }
  }

  Stream<List<OfferData>> getOffersBySeller(String sellerId) {
    try {
      final CollectionReference offersCollection = FirebaseFirestore.instance
          .collection('selleroffers');
      final Stream<
          QuerySnapshot<Map<String, dynamic>>> offerSnapshots = offersCollection
          .doc(sellerId).collection('offers').snapshots();

      return offerSnapshots.map((snapshot) {
        List<OfferData> offers = [];

        for (var doc in snapshot.docs) {
          try {
            OfferData offer = OfferData.fromSnapshot(doc);
            offers.add(offer);

          } catch (e) {
            doc.data().forEach((key, value) {
              print('$key: $value');
            });
          }
        }
        return offers;
      });
    } catch (e) {
      print('Error retrieving offers from Firestore: $e');

      // Show error snackbar (ensure showSnackbar is defined)


      return Stream.value([]); // Return an empty stream indicating failure
    }
  }

  Future<List<OfferData>> getSellerOffers(String sellerId) async {
    try {
      final CollectionReference offersCollection = FirebaseFirestore.instance
          .collection('selleroffers');
      final QuerySnapshot<
          Map<String, dynamic>> offerSnapshot = await offersCollection
          .doc(sellerId)
          .collection('offers')
          .get();

      List<OfferData> offers = [];

      for (var doc in offerSnapshot.docs) {
        try {
          OfferData offer = OfferData.fromSnapshot(doc);
          offers.add(offer);
        } catch (e) {
          print('Error converting document to OfferData: $e');
          // Print detailed information about each field to identify the problematic one
          print('Fields in document:');
          doc.data().forEach((key, value) {
            print('$key: $value');
          });
        }
      }
      return offers;
    } catch (e) {
      print('Error retrieving offers from Firestore: $e');
      return []; // Return an empty list indicating failure
    }
  }

  Future<OfferData?> getSellerOffer(String sellerId, String orderId) async {
    try {
      final CollectionReference offersCollection = FirebaseFirestore.instance.collection('offers');
      final DocumentSnapshot<Map<String, dynamic>> docSnapshot = await offersCollection
          .doc(orderId)
          .collection('offers')
          .doc(sellerId)
          .get();

      if (docSnapshot.exists) {
        return OfferData.fromSnapshot(docSnapshot);
      } else {
        print('Document does not exist');
        return null;
      }
    } catch (e) {
      print('Error retrieving offers from Firestore: $e');
      return null; // Return null indicating failure
    }
  }


  Stream<List<RequestData>> getOrderRequests() {
    try {
      final CollectionReference orderRequestCollection = FirebaseFirestore.instance.collection('orderrequest');

      return orderRequestCollection.snapshots().map((snapshot) => snapshot.docs.map((doc) {
                // Extract data from the document
                String orderid = doc.id;
                String customerId = doc['customerid'];
                String customerName = doc['customerName'];
                String dateTime = doc['dateTime'];
                String status = doc['status'];
                List<dynamic> itemsData = doc['items'];
                List<CartModel> items =
                    itemsData.map((item) => CartModel.fromJson(item)).toList();
                GeoPoint location = doc['location'];
                int distance=doc['distance'];
                int price=doc['price'];
                String sellerId=doc['sellerId'];
                GeoPoint sellerLocation=doc['sellerLocation'];

                // Create RequestData object
                return RequestData(
                    status: status,
                    customerId: customerId,
                    items: items,
                    customerName: customerName,
                    dateTime: dateTime,
                    location: location,
                    orderId: orderid,
                  distance: distance,
                  price: price,
                    sellerId: sellerId,
                  sellerLocation: sellerLocation
                );
              }).toList()
                // Sort the list of RequestData objects by date
                ..sort((request1, request2) {
                  try {
                    // Parse the date strings into DateTime objects
                    final parsedDate1 = DateTime.parse(request1.dateTime);
                    final parsedDate2 = DateTime.parse(request2.dateTime);

                    // Compare the DateTime objects
                    return parsedDate2.compareTo(parsedDate1);
                  } catch (e) {
                    // Error handling in case of invalid date strings
                    print("Error parsing dates: $e");
                    // Return 0 to maintain the current order if parsing fails
                    return 0;
                  }
                }));
    } catch (e) {
      print('Error getting order requests: $e');
      return Stream.empty();
    }
  }

  Stream<List<RequestData>> getOrder(String? userId) {
    try {
      final CollectionReference<Map<String, dynamic>> orderRequestCollection = FirebaseFirestore.instance.collection('orderrequest');

      return orderRequestCollection
          .where('customerid', isEqualTo: userId)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) {
                // Extract data from the document
                String orderid = doc.id;
                String customerId = doc['customerid'];
                String customerName = doc['customerName'];
                String dateTime = doc['dateTime'];
                String status = doc['status'];
                List<dynamic> itemsData = doc['items'];
                List<CartModel> items =
                    itemsData.map((item) => CartModel.fromJson(item)).toList();
                GeoPoint location=doc['location'];
                int distance=doc['distance'];
                int price=doc['price'];
                String sellerId=doc['sellerId'];
                GeoPoint sellerLocation=doc['sellerLocation'];

                // Create RequestData object
                return RequestData(
                  location: location,
                  orderId: orderid,
                  customerId: customerId,
                  items: items,
                  customerName: customerName,
                  dateTime: dateTime,
                  status: status,
                  distance: distance,
                  price: price,
                    sellerId: sellerId,
                  sellerLocation: sellerLocation
                );
              }).toList()
                // Sort the list of RequestData objects by date
                ..sort((request1, request2) {
                  try {
                    // Parse the date strings into DateTime objects
                    final parsedDate1 = DateTime.parse(request1.dateTime);
                    final parsedDate2 = DateTime.parse(request2.dateTime);

                    // Compare the DateTime objects
                    return parsedDate2.compareTo(parsedDate1);
                  } catch (e) {
                    // Error handling in case of invalid date strings
                    print("Error parsing dates: $e");
                    // Return 0 to maintain the current order if parsing fails
                    return 0;
                  }
                }));
    } catch (e) {
      print('Error getting order requests: $e');
      return Stream.empty();
    }
  }

  void removeOrder(String orderId) async {
    try {
      // Get a reference to the Firestore instance

      // Reference the collection with the order ID
      CollectionReference orders = _db.collection('orderrequest');

      // Delete the document with the given order ID
      await orders.doc(orderId).delete();

      print('Order with ID $orderId successfully removed.');
    } catch (e) {
      print('Error removing order: $e');
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



//========================================= OFERS ====================================================

  Future<bool> postOffers(OfferData offer, String userId) async {
    try {
      // Reference to the "offers" collection in Firestore
      final CollectionReference offersCollection = _db.collection('offers');

      // Use orderId as the document ID when adding to Firestore
      String orderId = offer.orderId; // Assuming orderId is a string in your OfferData
      String customerId = offer.sellerId; // Assuming customerId is a string in your OfferData

      // Reference to the specific orderId document in the "offers" collection
      final DocumentReference orderDocRef = offersCollection.doc(orderId);

      // Convert OfferData object to JSON format
      Map<String, dynamic> offerData = offer.toJson();

      // Add the offer data to the "offers" subcollection under orderId and use customerId as document ID
      final DocumentReference customerOfferDocRef = orderDocRef.collection('offers').doc(customerId);

      // Set the offer data under customerId document
      await customerOfferDocRef.set(offerData);

      print('Offer posted to Firestore under orderId: $orderId and customerId: $customerId');

      // Show success snackbar

      return true; // Return true indicating success
    } catch (e) {
      // Handle errors
      print('Error posting offer to Firestore: $e');

      //
      return false; // Return false indicating failure
    }
  }

  Future<bool> Offerstoseller(OfferData offer, String userId) async {
    try {
      // Reference to the "offers" collection in Firestore
      final CollectionReference offersCollection = _db.collection('selleroffers');

      // Use orderId as the document ID when adding to Firestore
      String orderId = offer.orderId; // Assuming orderId is a string in your OfferData
      String sellerId = offer.sellerId; // Assuming customerId is a string in your OfferData

      // Reference to the specific orderId document in the "offers" collection
      final DocumentReference orderDocRef = offersCollection.doc(sellerId);

      // Convert OfferData object to JSON format
      Map<String, dynamic> offerData = offer.toJson();

      // Add the offer data to the "offers" subcollection under orderId and use customerId as document ID
      final DocumentReference customerOfferDocRef = orderDocRef.collection('offers').doc(orderId);

      // Set the offer data under customerId document
      await customerOfferDocRef.set(offerData);

     // print('Offer posted to Firestore under orderId: $orderId and customerId: $customerId');

      // Show success snackbar


      return true; // Return true indicating success
    } catch (e) {
      // Handle errors
      print('Error posting offer to Firestore: $e');

      // Show error snackbar

      return false; // Return false indicating failure
    }
  }


  Future<void> deleteOffer(String orderId,String sellerId) async {
    try {
      // Reference to the "offers" collection in Firestore
      final CollectionReference offersCollection = _db.collection('offers');


      // Reference to the specific orderId document in the "offers" collection
      final DocumentReference orderDocRef = offersCollection.doc(orderId);

      // Add the offer data to the "offers" subcollection under orderId and use customerId as document ID
      final DocumentReference customerOfferDocRef = orderDocRef.collection('offers').doc(sellerId);

      // Set the offer data under customerId document
      await customerOfferDocRef.delete();


      // Show success snackbar
      showSnackbar(
        title: "Success",
        message: "Offer Canceled",
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    } catch (e) {
      // Handle errors
      print('Error posting offer to Firestore: $e');

      // Show error snackbar
      showSnackbar(
        title: "Error",
        message: "Failed to Cancel Offer.",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  Future<void> deleteOfferSeller(String orderId,String sellerId,String status) async {
    try {
      // Reference to the "offers" collection in Firestore
      final CollectionReference offersCollection = _db.collection('selleroffers');


      // Reference to the specific orderId document in the "offers" collection
      final DocumentReference orderDocRef = offersCollection.doc(sellerId);

      // Add the offer data to the "offers" subcollection under orderId and use customerId as document ID
      final CollectionReference customerOfferDocRef = orderDocRef.collection('offers');

      // Set the offer data under customerId document
      await customerOfferDocRef.doc(orderId).update({
        'status': status,
        // Add other fields to update here if necessary
      });



      // Show success snackbar

    } catch (e) {
      // Handle errors
      print('Error posting offer to Firestore: $e');

      // Show error snackbar

    }
  }
}
