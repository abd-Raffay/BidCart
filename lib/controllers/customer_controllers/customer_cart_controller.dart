

import 'dart:convert';

import 'package:bidcart/model/cart_model.dart';
import 'package:bidcart/model/product_model.dart';
import 'package:bidcart/repository/customer_repository/cart_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'customer_home_controller.dart';

class CartController extends GetxController {
  @override
  Future<void> onInit() async {
    // Perform initialization tasks herep
    await getProductsList();
    await loadCartFromDisk();
    await loadQuantitiesFromDisk();
    super.onInit();
  }

late GeoPoint location;
  static CartController get instance => Get.find();

  final homecontroller = Get.put(CustomerHomeController());
  final cartRepo = Get.put(CartRepository());

  late Future<List<ProductModel>> productListFuture;

  RxList<CartModel> cart = <CartModel>[].obs;
  List<ProductModel> productList = [];
  List<CartModel> quantities=[];
  late RxInt cartCount = 0.obs;





  Future<void> saveCartToDisk() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartJson = cart.map((item) => jsonEncode(item.toJson())).toList();
    bool isSaved = await prefs.setStringList('cart', cartJson);
    if (isSaved) {
      print("Cart data saved successfully");
    } else {
      print("Failed to save cart data");
    }
  }

  Future<void> loadCartFromDisk() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cartJson = prefs.getStringList('cart');
    if (cartJson != null) {
      cart.assignAll(cartJson.map((item) => CartModel.fromJson(jsonDecode(item))).toList());
    }
    print("CART issssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss ${cartJson?.length}");

  }

  Future<void> clearCartFromDisk() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('cart');

  }

  Future<void> saveQuantitiesToDisk() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> quantitiesJson = quantities.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList('quantities', quantitiesJson);
  }

  Future<void> loadQuantitiesFromDisk() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? quantitiesJson = prefs.getStringList('quantities');
    if (quantitiesJson != null) {
      quantities.assignAll(quantitiesJson.map((item) => CartModel.fromJson(jsonDecode(item))).toList());
    }

  }

  Future<void> clearQuantitiesFromDisk() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('quantities');
  }





  Future<void> addProductstoCart(productId, selectedsize, quantity) async {
    try {
      // Check if the product already exists in the cart
      if (cart.any((item) =>
      item.id == productId && item.size == selectedsize)) {
        for (int i = 0; i < cart.length; i++) {
          if (cart[i].id == productId && cart[i].size == selectedsize) {
            cart[i].quantity = cart[i].quantity + 1;
            Get.back();
            break;
          }
        }
      } else {
        for (int i = 0; i < productList.length; i++) {
          if (productList[i].id == productId) {
            var temp = CartModel(
              id: productList[i].id,
              image: productList[i].imageUrl,
              name: productList[i].name,
              size: selectedsize,
              quantity: 1,
            );
            cart.add(temp);
            Get.back();
            break;
          }
        }
      }

      await saveCartToDisk();
      await saveQuantitiesToDisk();

      // Display success message if no exceptions occur
      Get.snackbar("Success", "Product Added to Cart Successfully",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.cyan.withOpacity(0.1),
        duration: const Duration(milliseconds: 900),
        colorText: Colors.cyan,
      );
      // Increment cart count
      cartCount=RxInt(cart.length);
      print("Cart Length${cart.length}   cart count ${cartCount}");
      //print("product list Length${productList.length}");
    } catch (e) {
      // Catch any exceptions and display error message
      Get.snackbar("Error", "Please Select Size to add Product",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(0.1),
        duration: const Duration(milliseconds: 1000),
        colorText: Colors.red,
      );
    }
  }


  showCart() {
    print(cart.length);
    return Future.value(cart);
  }

  clearCart() async {
    try {
      cart.clear();
      await clearCartFromDisk();
      await clearQuantitiesFromDisk();
      quantities.clear();
      cartCount.value = 0;
      Get.back();
      //print("Cart Cleared ${cart.length}");
    } catch (e) {
      print("Error clearing cart: $e");
      Get.snackbar("Error", "An error occurred while clearing the cart",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(0.1),
        duration: const Duration(milliseconds: 4000),
        colorText: Colors.red,
      );
    }
  }


  sendRequest(GeoPoint location,int distance){

    cartRepo.saveOrderRequest(cart,location,distance);

  }
  //CartModel temp =CartModel.empty();

  Future<List<ProductModel>> getProductsList() async {
    print("RX SHOW PRODUCTS ");
    productListFuture = homecontroller.setList();
    productList = await productListFuture;
    return await productListFuture;
  }



  RxList<CartModel> cartItems() {
    return cart;
  }

  void removeProduct(String productId, String size) {
    try {
      cart.removeWhere((item) => item.id == productId && item.size == size);
      cartCount=RxInt(cart.length);
      Get.back();
      Get.snackbar("Success", "Product Removed ",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.cyan.withOpacity(0.1),
        duration: const Duration(milliseconds: 900),
        colorText: Colors.cyan,
      );

    } catch (e) {
      print('Error while removing product: $e');
      // Handle the error as per your application's requirements
    }
  }

  increaseQuantity(id, size) async {
    if (quantities.any((item) => item.id == id && item.size == size)) {
      for (int i = 0; i < quantities.length; i++) {
        if (quantities[i].id == id && quantities[i].size == size) { // Fix here
          quantities[i].quantity = quantities[i].quantity + 1;

          break;
        }
      }
    } else {

      var temp = CartModel(
        id: id,
        image: "",
        name: "",
        size: size,
        quantity: 1,
      );
      quantities.add(temp);
    }
    await saveQuantitiesToDisk();
  }

  decreaseQuantity(id,size) async {
    if (quantities.any((item) => item.id == id && item.size == size)) {
      for (int i = 0; i < quantities.length; i++) {
        if (quantities[i].id == id && quantities[i].size == size) { // Fix here
          quantities[i].quantity = quantities[i].quantity - 1;
          break;
        }
      }
    }
    await saveQuantitiesToDisk();
  }

  getQuantity(id,size) {

   for (int i = 0; i < quantities.length; i++) {
      //print("Quantuty.length");
      if (quantities[i].id == id && quantities[i].size == size ) {
       return quantities[i].quantity;
      }
    }
  }

  RxInt getCartCounter(){
    return RxInt(cart.length);
  }


  // -------------- Dialogs-----------------------------
  showClearCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shadowColor: Colors.white10,
          title: const Text("Clear Cart"),
          content: const Text("Are you sure you want to clear your cart? This action cannot be undone."),
          actions: [
            TextButton(
              onPressed: () {
                clearCart();
                // Add your logic for OK button
              },
              child: const Text("OK"),
            ),
            TextButton(
              onPressed: () {
                // Add your logic for cancel button
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  showDeleteDialog(BuildContext context,id,size) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shadowColor: Colors.white10,
          title: const Text("Delete item"),
          content: const Text("Are you sure you want to delete this item? This action cannot be undone."),
          actions: [
            TextButton(
              onPressed: () {
                removeProduct(id, size);
                //clearCart();


                // Add your logic for OK button
              },
              child: const Text("OK"),
            ),
            TextButton(
              onPressed: () {
                // Add your logic for cancel button
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

}
