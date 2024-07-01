import 'package:bidcart/const/sizes.dart';
import 'package:bidcart/controllers/seller_controllers/seller_offer_controller.dart';
import 'package:bidcart/controllers/seller_controllers/seller_request_controller.dart';
import 'package:bidcart/model/request_model.dart';
import 'package:bidcart/widget/Text/heading.dart';
import 'package:bidcart/widget/Text/labeltext.dart';
import 'package:bidcart/widget/seller/order_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellerRequestCards extends StatelessWidget {
  const SellerRequestCards({
    Key? key,
    required this.requests,
    required this.total,
    required this.available,
  }) : super(key: key);

  final RequestData requests;
  final int total;
  final int available;

  @override
  Widget build(BuildContext context) {
    final offerController = Get.put(SellerOfferController());

    return GestureDetector(
        onTap: () async {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return OrderDetails(products: requests.items);
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            height: 100,
            child: Card(
              color: Colors.white,
              shadowColor: Colors.black,
              elevation: 4,
              // Adding elevation for a raised effect
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              // Adding rounded corners
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.person,
                              size: Sizes.md,
                            ),
                            const SizedBox(width: 5),
                            HeadingText(title: requests.customerName),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.date_range_outlined,
                              size: Sizes.md,
                            ),
                            const SizedBox(width: 5),
                            LabelText(title: requests.dateTime),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              CupertinoIcons.cart,
                              size: Sizes.md,
                            ),
                            const SizedBox(width: 5),
                            LabelText(
                                title: "Product Available: $available/$total"),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            if (requests.status != "pending" &&
                                available != 0 &&
                                requests.status != "accepted")
                              ElevatedButton(
                                onPressed: () {
                                  offerController.sendOffer(requests.orderId!);
                                  print(
                                      "Accepted %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
                                  // Handle accept action
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(10),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.check_circle_outline,size:Sizes.md),
                                    SizedBox(width: 2,),
                                    const Text(
                                      "Accept",
                                      style: TextStyle(fontSize: Sizes.fontSizeSm),
                                    ),
                                  ],
                                ),
                              ),
                            if (requests.status != "pending" &&
                                available != 0 &&
                                requests.status != "accepted")
                              const SizedBox(width: 8),
                            if (requests.status != "pending" &&
                                available != 0 &&
                                requests.status != "accepted")
                              ElevatedButton(
                                onPressed: () {
                                  offerController
                                      .rejectOffer(requests.orderId!);
                                  // Handle reject action
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(10),
                                  backgroundColor: Colors.red,
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.cancel_outlined,size:Sizes.md),
                                    SizedBox(width: 2,),
                                    const Text(
                                      "Reject",
                                      style: TextStyle(fontSize: Sizes.fontSizeSm),
                                    ),
                                  ],
                                ),
                              ),
                            if (requests.status != "pending" &&
                                available == 0 &&
                                requests.status != "accepted")
                              Column(children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.block,
                                      size: Sizes.md,
                                      color: Colors.red,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    const LabelText(
                                      title: "No Products to Sell",
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    offerController
                                        .rejectOffer(requests.orderId!);
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete_forever,size: Sizes.md,),
                                      Text(
                                        "Remove",
                                        style: TextStyle(
                                            fontSize: Sizes.fontSizeSm),
                                      ),
                                    ],
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(10),
                                    backgroundColor: Colors.red,
                                  ),
                                ),
                              ]),
                            if (requests.status == "pending")
                              Row(
                                children: [
                                  Icon(
                                    Icons.pending,
                                    size: Sizes.md,
                                    color: Colors.orange,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  const LabelText(
                                    title: "Pending",
                                    color:
                                        Colors.orange, // Adjust color as needed
                                  ),
                                ],
                              ),
                            if (requests.status == "accepted")
                              Row(
                                children: [
                                  Icon(
                                    Icons.check_circle_outline,
                                    size: Sizes.md,
                                    color: Colors.green,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  const LabelText(
                                    title: "Completed",
                                    color:
                                        Colors.green, // Adjust color as needed
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
