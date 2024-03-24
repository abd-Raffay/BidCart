import 'package:bidcart/const/sizes.dart';
import 'package:bidcart/widget/container/circular_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX package

class AddRemoveButtons extends StatelessWidget {
   AddRemoveButtons({
    super.key,
     required this.quantity,
  });

  final RxInt quantity ;


  @override
  Widget build(BuildContext context) {
    // Create an RxInt variable to hold the quantity value
   // final RxInt quantity = 2.obs;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularIcon(
          icon: CupertinoIcons.minus,
          width: 42,
          height: 42,
          size: Sizes.md,
          color: Colors.black,
          backgroundColor: Colors.grey.shade200,
          onPressed: () {
            // Decrease the quantity when the minus button is pressed
            if (quantity.value > 0) {
              quantity.value--;
            }
          },
        ),
        const SizedBox(width: Sizes.spaceBtwItems),
        // Use Obx to update the Text widget whenever the quantity changes
        Obx(() => Text(quantity.value.toString())),
        const SizedBox(width: Sizes.spaceBtwItems),
        CircularIcon(
          icon: CupertinoIcons.add,
          width: 42,
          height: 42,
          size: Sizes.md,
          color: Colors.white,
          backgroundColor: Colors.cyan,
          onPressed: () {
            // Increase the quantity when the add button is pressed
            quantity.value++;
          },
        ),
      ],
    );
  }
}
