import 'package:bidcart/const/sizes.dart';
import 'package:bidcart/controllers/seller_controllers/seller_offer_controller.dart';
import 'package:bidcart/controllers/seller_controllers/seller_request_controller.dart';
import 'package:bidcart/model/request_model.dart';
import 'package:bidcart/widget/Text/heading.dart';
import 'package:bidcart/widget/Text/labeltext.dart';
import 'package:bidcart/widget/admin/reviews.dart';
import 'package:bidcart/widget/seller/order_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/review_model.dart';
import '../../repository/seller_repository/seller_store_repository.dart';

class SellerRequestCards extends StatelessWidget {
   SellerRequestCards({
    Key? key,
    required this.requests,
    required this.total,
    required this.totalavailable
  }) : super(key: key);

  final RequestData requests;
  final int total;
  final int totalavailable;


  @override
  Widget build(BuildContext context) {
    final offerController = Get.put(SellerOfferController());
    final requestController=Get.put(SellerRequestController());

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
            height: 120,
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
                        LabelText(title: requests.orderId!),
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
                        if (requests.status == "null" && totalavailable != 0)
                        Row(
                          children: [
                            const Icon(
                              CupertinoIcons.cart,
                              size: Sizes.md,
                            ),
                            const SizedBox(width: 5),
                            LabelText(
                                title: "Product Available: $totalavailable/$total"),
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
                            if (requests.status == "null" && totalavailable != 0)
                              ElevatedButton(
                                onPressed: () {

                                  offerController.sendOffer(requests.orderId!);

                                  // Handle accept action
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(10),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.check_circle_outline,
                                        size: Sizes.md),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    const Text(
                                      "Accept",
                                      style:
                                          TextStyle(fontSize: Sizes.fontSizeSm),
                                    ),
                                  ],
                                ),
                              ),
                            if (requests.status == "null" && totalavailable != 0 )
                              const SizedBox(width: 8),

                            if (requests.status == "null" && totalavailable != 0)
                              ElevatedButton(
                                onPressed: () {
                                  offerController.rejectOffer(requests.orderId!);
                                  // Handle reject action
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(10),
                                  backgroundColor: Colors.red,
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.cancel_outlined, size: Sizes.md),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    const Text(
                                      "Reject",
                                      style:
                                          TextStyle(fontSize: Sizes.fontSizeSm),
                                    ),
                                  ],
                                ),
                              ),
                            if (requests.status == "null" && totalavailable == 0 || total == 0)
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
                                      Icon(
                                        Icons.delete_forever,
                                        size: Sizes.md,
                                      ),
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
                              Column(
                                children: [
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
                                        color: Colors
                                            .orange, // Adjust color as needed
                                      ),
                                    ],
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      final _auth = FirebaseAuth.instance;
                                      String? sellerId=_auth.currentUser?.uid;
                                      //print("REQUEST ID ${requests.orderId} && SELLER ID ${requests.sellerId}");
                                      if (requests.orderId != null ) {
                                        await offerController.cancelOffer(requests.orderId!,sellerId!,"cancelled");

                                      } else {
                                        // Handle the case where requests.orderId or requests.sellerId is null
                                        print('Error: orderId or sellerId is null.');
                                      }

                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.block,
                                          size: Sizes.md,
                                          color: Colors.red,
                                        ),
                                        Text(
                                          "Cancel",
                                          style: TextStyle(
                                              fontSize: Sizes.fontSizeSm,
                                              color: Colors.red),
                                        ),
                                      ],
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(10),
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                ],
                              ),

                            if (requests.status == "accepted" || requests.status == "completed")
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
                            if (requests.status == "reviewed" )
                              ElevatedButton(
                                onPressed: () {
                                  Review review;
                                  try {
                                    review = requestController.getOrderReview(requests.sellerId!, requests.orderId!);
                                    showReviewDialog(context, review);
                                  } catch (e) {
                                    // Handle the case where no review is found, e.g., set review to null or a default value
                                   print("no review"); // or provide a default Review object
                                  }


                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.rate_review_outlined,
                                      size: Sizes.md,
                                    ),
                                    Text(
                                      "View Review",
                                      style: TextStyle(
                                          fontSize: Sizes.fontSizeSm),
                                    ),
                                  ],
                                ),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(10),

                                ),
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
