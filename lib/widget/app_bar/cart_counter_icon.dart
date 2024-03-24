
import 'package:bidcart/screens/customer/customer_cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartCounterIcon extends StatelessWidget {
  const CartCounterIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      IconButton(onPressed: () {Get.to(const CustomerCartScreen());}, icon: const Icon(CupertinoIcons.shopping_cart)),
      Positioned(
        right: 0,
        child: Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: Colors.cyan,
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Center(child: Text('2',style: TextStyle(color: Colors.white70),)),

        ),
      )
    ]);
  }
}