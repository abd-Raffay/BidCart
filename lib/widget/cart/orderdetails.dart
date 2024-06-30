import 'dart:ffi';

import 'package:bidcart/const/sizes.dart';
import 'package:bidcart/controllers/customer_controllers/customer_order_controller.dart';
import 'package:bidcart/screens/customer/customer_bids_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bidcart/widget/Text/heading.dart';
import 'package:bidcart/widget/Text/labeltext.dart';
import 'package:get/get.dart';

class OrderDetailCard extends StatelessWidget {
  OrderDetailCard({
    super.key,
    required this.orderId,
    required this.date,
    required this.totalProucts,
  });

  String orderId;
  String date;
  int totalProucts;

  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(CustomerOrderController());
    return SizedBox(
      height: 130, // Fixed height for the card
      child: Card(
        color: Colors.white,
        shadowColor: Colors.black,
        elevation: 4,
        // Adding elevation for a raised effect
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Adding rounded corners
        ),
        child: Padding(
          padding: const EdgeInsets.all(10), // Adjusting padding
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const HeadingText(title: "Order ID #  "),
                      LabelText(title: orderId.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.date_range_outlined,
                        size: Sizes.md,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      LabelText(title: date),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.account_balance_rounded,
                        size: Sizes.md,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      const LabelText(title: "Total Products : "),
                      LabelText(title: (totalProucts).toString()),
                    ],
                  ),
                ],
              ),
              // Right side button
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(10),
                        backgroundColor: Colors.red.shade800),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Confirmation'),
                              content: const Text(
                                  'Are you sure you want to delete this item?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Perform deletion logic here
                                    orderController.removeOrder(orderId!);
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: const Text('Delete'),
                                ),
                              ],
                            );
                          });

                      // Add your onPressed logic here
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.cancel,
                          size: Sizes.fontSizeMd,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          'Cancel',
                          style: TextStyle(fontSize: Sizes.fontSizeSm),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(padding: const EdgeInsets.all(10)),
                    child: Row(
                      children: [
                        Icon(Icons.remove_red_eye,size: Sizes.md,),
                        const Text("View Bids",
                            style: TextStyle(fontSize: Sizes.fontSizeSm)),
                      ],
                    ),
                    onPressed: () {
                      Get.to(BidScreen(orderid: orderId,totalProducts: totalProucts));
                      orderController.getOffers(orderId);


                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
