import 'dart:ffi';

import 'package:bidcart/const/sizes.dart';
import 'package:bidcart/controllers/customer_controllers/customer_order_controller.dart';
import 'package:bidcart/screens/customer/customer_bids_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bidcart/widget/Text/heading.dart';
import 'package:bidcart/widget/Text/labeltext.dart';
import 'package:get/get.dart';

import '../modal/distance.dart';

class OrderDetailCard extends StatelessWidget {
  OrderDetailCard({
    super.key,
    required this.orderId,
    required this.date,
    required this.totalProducts,
    required this.status,
    required this.height,
    required this.distance

  });
  double height;
  String orderId;
  String date;
  int totalProducts;
  String status;
  int distance;

  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(CustomerOrderController());

    return SizedBox(
      height: 140, // Fixed height for the card
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
                      LabelText(title: (totalProducts).toString()),

                    ],
                  ),

                  Row(
                    children: [
                      const Icon(
                        Icons.social_distance,
                        size: Sizes.md,
                      ),
                      const SizedBox(width: 5),
                      LabelText(
                          title:
                          "Distance: ${distance.toString()} meters"),
                      IconButton(onPressed: () async {
                        int newdistance=0;
                        newdistance =  await showRadiusDialog(context);
                        orderController.updateDistance(newdistance,orderId);

                      }, icon: Icon(CupertinoIcons.add_circled,size: Sizes.md,),)
                    ],

                  ),
                ],
              ),
              // Right side button
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (status == "accepted")
                    Row(
                      children: [
                        Icon(Icons.check_circle_outline,size: Sizes.md,color: Colors.green,),
                        const Text(
                          'Completed',
                          style: TextStyle(
                            fontSize: Sizes.fontSizeSm,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    )
                  else
                    Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(10),
                            backgroundColor: Colors.red.shade800,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Confirmation'),
                                  content: const Text('Are you sure you want to delete this item?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); // Close the dialog
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Perform deletion logic here
                                        orderController.removeOrder(orderId!);
                                        Navigator.of(context).pop(); // Close the dialog
                                      },
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                );
                              },
                            );

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
                        SizedBox(width: Sizes.spaceBtwItems / 2),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(10)),
                          child: Row(
                            children: [
                              Icon(Icons.remove_red_eye, size: Sizes.md),
                              const Text(
                                "View Bids",
                                style: TextStyle(fontSize: Sizes.fontSizeSm),
                              ),
                            ],
                          ),
                          onPressed: () {
                            Get.to(BidScreen(orderid: orderId, totalProducts: totalProducts));
                            orderController.getOffers(orderId);
                          },
                        ),
                      ],
                    ),

                ],
                    ),

                ],


          ),
        ),
      ),
    );
  }
}
