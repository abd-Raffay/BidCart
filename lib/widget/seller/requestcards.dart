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
    //required this.index,
    required this.total,
    required this.available,
    required this.status,
  }) : super(key: key);

  final RequestData requests;

  //final int index;
  final int total;
  final int available;
  final String status;

  @override
  Widget build(BuildContext context) {
    final requestController = Get.put(SellerRequestController());
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
                            if (requests.status != "pending" && available != 0)
                              ElevatedButton(
                                onPressed: () {
                                  offerController.sendOffer(requests.orderId!);

                                  // Handle accept action
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                  textStyle: const TextStyle(fontSize: Sizes.fontSizeSm),
                                  backgroundColor: Colors.green[600],
                                ),
                                child: const Text("Accept"),
                              ),

                            if (requests.status != "pending" && available != 0)
                              const SizedBox(width: 8),

                            if (requests.status != "pending" && available != 0)
                              ElevatedButton(
                                onPressed: () {
                                  offerController.rejectOffer(requests.orderId!);
                                  // Handle reject action
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                  textStyle: const TextStyle(fontSize: Sizes.fontSizeSm),
                                  backgroundColor: Colors.red[600],
                                ),
                                child: const Text("Reject"),
                              ),

                            if (requests.status != "pending" && available == 0)
                              const LabelText(
                                title: "No Products to Sell",
                                color: Colors.red,
                              ),

                            if (requests.status == "pending")
                              const LabelText(
                                title: "Pending",
                                color: Colors.grey, // Adjust color as needed
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
