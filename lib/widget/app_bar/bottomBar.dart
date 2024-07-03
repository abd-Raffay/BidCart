import 'package:bidcart/controllers/customer_controllers/customer_cart_controller.dart';
import 'package:bidcart/controllers/seller_controllers/seller_store_controller.dart';
import 'package:bidcart/model/seller_inventory.dart';
import 'package:bidcart/screens/customer/customer_map_screen.dart';
import 'package:bidcart/screens/customer/customer_orderscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modal/distance.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.buttontext,

    this.size,
    this.productId,
    this.quantity,
    required this.functionality,
    this.product,
    this.location
  });

  final String? productId;
  final String? size;
  final String buttontext;
  final int? quantity;
 final String functionality;
final GeoPoint? location;
 final Inventory? product;



  @override
  Widget build(BuildContext context) {
    int distance=0;
    final cartController=Get.put(CartController());
    final sellerStoreController=Get.put(SellerStoreController());
    return BottomAppBar(
      color: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      child: ElevatedButton(
        onPressed: () async {
          print(productId);

              int qty=0;
            if (functionality == "add") {
              //print("Size ${size}");
              // print("ID ${productId}");
              qty=await cartController.getQuantity(productId, size);
              //print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ${qty} %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");

              cartController.addProductstoCart(productId, size, qty);
            }
            else if (functionality == "sendrequest") {
              int distance;




              distance =  await showRadiusDialog(context);
              if(distance > 0) {
                cartController.sendRequest(location!, distance);
                cartController.clearCart();
                Get.to(const CustomerOrderScreen());


                Get.snackbar("Sucess", "Order Request Sent ",
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.green.shade400,
                  duration: const Duration(milliseconds: 1500),
                  colorText: Colors.white,
                );
              }
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
            else if(functionality == "selectlocation"){
              Get.to(CustomerMapScreen());

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