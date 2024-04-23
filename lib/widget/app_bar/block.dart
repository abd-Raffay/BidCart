import 'package:bidcart/controllers/admin_controllers/admin_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlockSeller extends StatelessWidget {
  BlockSeller({
    Key? key,
    required this.storeId,
    required this.status,
  }) : super(key: key);

  final String storeId;
  final RxString status;

  @override
  Widget build(BuildContext context) {
    final adminController = Get.put(AdminController());

    return Obx(() {
      return ElevatedButton(
        onPressed: () {
          if (status.value.toLowerCase() == 'blocked') {
            adminController.setStatus(storeId, "approved"); // Unblock the seller
            status.value = "approved";
          } else {
            adminController.setStatus(storeId, "blocked"); // Block the seller
            status.value = "blocked";
          }
          Get.back();
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(10),
          backgroundColor: status.value.toLowerCase() == 'blocked' ? Colors.green : Colors.red.shade600,
        ),
        child: Row(
          children: [
            Icon(
              Icons.block,
              size: 20,
              color: Colors.white,
            ),
            const SizedBox(width: 4),
            Text(
              status.value.toLowerCase() == 'blocked' ? "Unblock this Seller" : "Block this Seller",
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
          ],
        ),
      );
    });
  }
}
