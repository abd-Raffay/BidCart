import 'package:bidcart/model/cart_model.dart';
import 'package:bidcart/model/product_model.dart';
import 'package:bidcart/model/request_model.dart';
import 'package:bidcart/model/seller_products_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SellerStoreRepository extends GetxController{

  SellerStoreRepository get instance  => Get.find();

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

  Future<void> saveToInventory(SellerProductModel product) async {
    try {

      final CollectionReference inventoryCollection = _db.collection('inventory');

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
        final CollectionReference productsCollection = userDocRef.collection('products');

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

  Future<List<SellerProductModel>> getProductsFromInventory() async {
    try {
      final String? userId = _auth.currentUser?.uid;
      if (userId != null) {
        print(userId);
        final CollectionReference inventoryCollection = _db.collection('inventory');
        final DocumentReference userDocRef = inventoryCollection.doc(userId);
        final CollectionReference productsCollection = userDocRef.collection('products');

        final snapshot = await productsCollection.get();

        List<SellerProductModel> products = [];
        //print()

        snapshot.docs.forEach((doc) {
          print(doc.data());
          print(doc.id);
          SellerProductModel product = SellerProductModel.fromSnapshot(doc as DocumentSnapshot<Map<String, dynamic>>);
          products.add(product);
          print(product.toJson());
        });
        return products;
      } else {
        print('User not authenticated.');
        return [];
      }
    } catch (e) {
      print('Error getting products from inventory: $e');
      return [];
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      final CollectionReference inventoryCollection = FirebaseFirestore.instance.collection('inventory');


      if (_auth.currentUser?.uid != null) {
        final DocumentReference userDocRef = inventoryCollection.doc(_auth.currentUser?.uid);
        final CollectionReference productsCollection = userDocRef.collection('products');

        // Delete the document with the specified product ID
        await productsCollection.doc(productId).delete();
      } else {
        print('User not authenticated.');
      }
    } catch (e) {
      print('Error deleting product: $e');
    }
  }



  Stream<List<RequestData>> getOrderRequests() {
    try {
      final CollectionReference orderRequestCollection = FirebaseFirestore.instance.collection('orderrequest');

      return orderRequestCollection.snapshots().map((snapshot) => snapshot.docs.map((doc) {
        // Extract data from the document
        String customerId = doc['customerid'];
        String customerName = doc['customerName'];
        String dateTime = doc['dateTime'];
        List<dynamic> itemsData = doc['items'];
        List<CartModel> items = itemsData.map((item) => CartModel.fromJson(item)).toList();

        // Create RequestData object
        return RequestData(
          customerId: customerId,
          items: items,
          customerName: customerName,
          dateTime: dateTime,
        );
      }).toList());
    } catch (e) {
      print('Error getting order requests: $e');
      return Stream.empty();
    }
  }






}







