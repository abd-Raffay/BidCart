import 'package:bidcart/controllers/customer_controllers/customer_cart_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.buttontext,

    this.size,
    this.productId, this.quantity, required this.functionality,
  });

  final String? productId;
  final String? size;
  final String buttontext;
  final int? quantity;
 final String functionality;

  @override
  Widget build(BuildContext context) {
    final cartController=Get.put(CartController());
    return BottomAppBar(
      color: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      child: ElevatedButton(
        onPressed: () {
          if(functionality == "add") {
            //print("Size ${size}");
            // print("ID ${productId}");
            cartController.addProductstoCart(productId, size, quantity);
          }else if(functionality == "sendrequest"){
            cartController.sendRequest();
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