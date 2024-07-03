import 'package:bidcart/const/sizes.dart';
import 'package:bidcart/controllers/customer_controllers/customer_cart_controller.dart';
import 'package:bidcart/widget/container/circular_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX package

class AddRemoveButtons extends StatelessWidget {
  const AddRemoveButtons({
    super.key,
    required this.quantity,
    required this.id, required this.size,
  });
final String id;
  final RxInt quantity;
  final String size;


  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
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
            if (quantity.value > 1) {
              cartController.decreaseQuantity(id,size);
              quantity.value--;
              //cartController.setQuantity(id,size,quantity.value,);
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
            cartController.increaseQuantity(id,size);
            //cartController.setQuantity(id,size,quantity.value,);

          },
        ),
      ],
    );
  }
}
