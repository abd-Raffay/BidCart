import 'package:bidcart/controllers/customer_controllers/customer_cart_controller.dart';
import 'package:bidcart/controllers/seller_controllers/seller_store_controller.dart';
import 'package:bidcart/model/seller_inventory.dart';
import 'package:bidcart/screens/customer/customer_orderscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.buttontext,

    this.size,
    this.productId,
    this.quantity,
    required this.functionality,
    this.product,
  });

  final String? productId;
  final String? size;
  final String buttontext;
  final int? quantity;
 final String functionality;

 final Inventory? product;


  @override
  Widget build(BuildContext context) {
    final cartController=Get.put(CartController());
    final sellerStoreController=Get.put(SellerStoreController());
    return BottomAppBar(
      color: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      child: ElevatedButton(
        onPressed: () {

            if (functionality == "add") {
              //print("Size ${size}");
              // print("ID ${productId}");
              cartController.addProductstoCart(productId, size, quantity);
            } else if (functionality == "sendrequest") {
              cartController.sendRequest();
              Get.to(CustomerOrderScreen());
            }
            else if (functionality == "addsellerproduct") {
              if (sellerStoreController.quantityController.text.isEmpty ||
                  sellerStoreController.prizeController.text.isEmpty ||
                  sellerStoreController.dateController.text.isEmpty ||
                  sellerStoreController.batchController.text.isEmpty ||
                  sellerStoreController.size.isEmpty) {
                // Show error message indicating all fields must be filled
                Get.snackbar("Failed", "Please fill each field ",
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.red.shade400,
                  duration: const Duration(milliseconds: 1500),
                  colorText: Colors.white,
                );
              }else {
                sellerStoreController.addProducttoInventory(product!);
                sellerStoreController.quantityController.text="";
                    sellerStoreController.prizeController.text="";
                    sellerStoreController.dateController.text="";
                    sellerStoreController.batchController.text="";
                    sellerStoreController.size="";

                Get.back();

                Get.snackbar("Success", "Product added to Inventory",
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.cyan.withOpacity(0.1),
                  duration: const Duration(milliseconds: 1000),
                  colorText: Colors.cyan,
                );

              }
            }



        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          // Adjust padding as needed
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(CupertinoIcons.cart),
            const SizedBox(width: 20,),
            Text(buttontext),

          ],
        ),
      ),

    );
  }
}