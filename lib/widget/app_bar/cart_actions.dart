import 'package:bidcart/controllers/customer_controllers/customer_cart_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartActions extends StatelessWidget {
  const CartActions({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    return Stack(
      children: [
        TextButton(onPressed: (){
          cartController.showClearCartDialog(context);
        } , child: const Row(
          children: [
            Icon(CupertinoIcons.bin_xmark,size: 20,color: Colors.black,),
            SizedBox(width: 4,),
            Text("Clear Cart",style: TextStyle(fontSize: 12,color: Colors.black),),
          ],

        ))


    ]

    );
  }
}
