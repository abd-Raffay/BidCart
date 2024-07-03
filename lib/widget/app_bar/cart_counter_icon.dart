import 'package:bidcart/controllers/customer_controllers/customer_cart_controller.dart';
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
    final cartController = Get.put(CartController());

    return Stack(
      children: [
        IconButton(
          onPressed: () {
            Get.to(()=> CustomerCartScreen());
          },
          icon: const Icon(CupertinoIcons.shopping_cart),
        ),
        Positioned(
          right: 0,
          child: Obx(
            () => Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: Colors.cyan,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Text(
                  '${cartController.getCartCounter()}',
                  style: const TextStyle(color: Colors.white70),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
