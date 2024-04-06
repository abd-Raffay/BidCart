

import 'package:bidcart/model/cart_model.dart';
import 'package:bidcart/model/product_model.dart';
import 'package:bidcart/repository/customer_repository/cart_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'customer_home_controller.dart';

class CartController extends GetxController {
  @override
  Future<void> onInit() async {
    // Perform initialization tasks herep
    await getProductsList();
    print('Controller initialized');
    super.onInit();
  }

  static CartController get instance => Get.find();

  final homecontroller = Get.put(CustomerHomeController());
  final cartRepo = Get.put(CartRepository());

  late Future<List<ProductModel>> productListFuture;

  RxList<CartModel> cart = <CartModel>[].obs;
  List<ProductModel> productList = [];
  List<CartModel> quantities=[];
  RxInt cartCount = 0.obs;
  int quantity = 0;


  sendRequest(){

    cartRepo.saveOrderRequest(cart);

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




  //List<ProductModel> cart=ProductModel.empty();

  void addProductstoCart(productId, selectedsize, quantity) {
    try {
      print("Product id ${productId}");
      print("Selected Size ${selectedsize}");
      print("Quantity ${quantity}");

      // Check if the product already exists in the cart
      if (cart.any((item) =>
      item.id == productId && item.size == selectedsize)) {
        for (int i = 0; i < cart.length; i++) {
          if (cart[i].id == productId && cart[i].size == selectedsize) {
            cart[i].quantity = cart[i].quantity + 1;
            Get.back();
            //cart[i].quantity = quantity;
            break; // Once the item is found and updated, we can exit the loop
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
              quantity: 1, // You may initialize it here or later based on your logic
            );
            cart.add(temp);
            Get.back();
            break; // Once the item is found and updated, we can exit the loop
          }
        }
      }

      // Display success message if no exceptions occur
      Get.snackbar("Success", "Product Added to Cart Successfully",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.cyan.withOpacity(0.1),
        duration: const Duration(milliseconds: 900),
        colorText: Colors.cyan,
      );

      // Increment cart count
      cartCount++;
      print("Cart Length${cart.length}");
      print("product list Length${productList.length}");
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
  clearCart() {
    try {
      cart.clear();
      cartCount.value = 0;
      Get.back();
      //print("Cart Cleared ${cart.length}");
      Get.snackbar("Success", "Cart Cleared Successfully",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.cyan.withOpacity(0.1),
        duration: const Duration(milliseconds: 1000),
        colorText: Colors.cyan,
      );
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

  removeProducts() {}


  increaseQuantity(id,size) {
    for (int i = 0; i < cart.length; i++) {
      if (cart[i].id == id && cart[i].size==size) {
        cart[i].quantity = cart[i].quantity + 1;
      }
    }
  }
  decreaseQuantity(id,size) {
    for (int i = 0; i < cart.length; i++) {
      if (cart[i].id == id && cart[i].size == size) {
        cart[i].quantity = cart[i].quantity - 1;
      }
    }
  }
  getQuantity(id) {
    for (int i = 0; i < quantities.length; i++) {
      if (quantities[i].id == id ) {
       return quantities[i].quantity;
      }
    }
  }
  setQuantity(id,quantity) {
    if (quantities.any((item) => item.id == id  )) {
      for (int i = 0; i < quantities.length; i++) {
        if (quantities[i].id == id) {
          quantities[i].quantity = quantity;
        }
      }
    }else{
      var temp = CartModel(
        id: id,
        quantity: quantity,
        name: '',
        image: '',
        size: '', // You may initialize it here or later based on your logic
      );
      quantities.add(temp);
    }
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
