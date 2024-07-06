import 'package:bidcart/controllers/customer_controllers/customer_order_controller.dart';
import 'package:bidcart/widget/bids/bids_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bidcart/model/offer_model.dart'; // Replace with your OfferData model import
import 'package:bidcart/widget/Text/heading.dart'; // Replace with your HeadingText widget import
import 'package:bidcart/widget/Text/labeltext.dart'; // Replace with your LabelText widget import
import 'package:bidcart/const/sizes.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/seller_controllers/seller_offer_controller.dart'; // Replace with your Sizes constants

class BidCard extends StatelessWidget {
  final OfferData offer;
  final int totalproducts;// Declare offer as a required parameter

  const BidCard({
    required this.offer,
    required this.totalproducts,// Constructor parameter marked as required
    Key? key, // Optional key parameter for widget identification
  }) : super(key: key);

  String formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd/MM/yy HH:mm:ss');
    return formatter.format(dateTime);
  }
  @override
  Widget build(BuildContext context) {
    final orderController=Get.put(CustomerOrderController());
    return GestureDetector(
      onTap: () {
        if(offer.status != "rejected") {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return BidDetails(bid: offer);
            },
          );
        }
      },
      child: Container(
        height: 130,
        child: Card(
          color: Colors.white,
          shadowColor: Colors.black,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Seller name at the top
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Icon(Icons.store),
                      HeadingText(
                          title: offer.sellerName),
                    ],
                  ), // Replace with actual field from OfferData
                ),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            LabelText(
                              title: "Total Products: ${offer.items.length} ",

                            ),
                            LabelText(
                              title: "Total Price: RS ${offer.totalPrice}",
                              color: Colors.black,
                            ),
                            LabelText(
                              title: offer.dateTime,
                              color: Colors.black,
                            ),

                          ],
                        ),
                        // Replace with actual field from OfferData
                        SizedBox(height: Sizes.spaceBtwItems),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (offer.status != "rejected") // Show buttons if status is not "rejected"
                              ElevatedButton(
                                onPressed: () {
                                  // Handle accept action
                                  orderController.acceptOrder(offer.sellerId, offer.orderId);
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(10),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      size: Sizes.fontSizeMd,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      'Accept',
                                      style: TextStyle(fontSize: Sizes.fontSizeSm),
                                    ),
                                  ],
                                ),
                              ),
                            SizedBox(width: Sizes.spaceBtwItems / 2),
                            if (offer.status != "rejected")  // Show reject button if status is not "rejected"
                              ElevatedButton(
                                onPressed: () {
                                  // Handle reject action
                                  //final offerController = Get.put(SellerOfferController());
                                  //offerController.cancelOffer(offer.orderId, offer.sellerId);
                                  orderController.rejectOrder(offer.orderId,offer.sellerId);
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(10),
                                  backgroundColor: Colors.red.shade800,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.cancel,
                                      size: Sizes.fontSizeMd,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      'Reject',
                                      style: TextStyle(fontSize: Sizes.fontSizeSm),
                                    ),
                                  ],
                                ),
                              ),
                            if (offer.status == "rejected") // Show "Rejected" text if status is "rejected"
                              Padding(
                                padding: const EdgeInsets.all(11.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.cancel_outlined,size: Sizes.md,color: Colors.red,),
                                    Text(
                                      'Rejected',
                                      style: TextStyle(
                                        fontSize: Sizes.fontSizeSm,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
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
    );
  }
}
