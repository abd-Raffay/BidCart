import 'dart:ffi';

import 'package:bidcart/const/sizes.dart';
import 'package:bidcart/controllers/customer_controllers/customer_cart_controller.dart';
import 'package:bidcart/controllers/customer_controllers/customer_order_controller.dart';
import 'package:bidcart/model/offer_model.dart';
import 'package:bidcart/screens/customer/customer_bids_screen.dart';
import 'package:bidcart/widget/modal/address_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    required this.distance,
    required this.price,
    required this.offer,
    required this.sellerId,
    required this.sellerLocation,
    this.customerLocation,
    //this. address,
  });
  OfferData? offer;
  double height;
  String orderId;
  String date;
  int totalProducts;
  String status;
  int distance;
  int price;
  String sellerId;
  //String? address;
  GeoPoint? customerLocation;
  GeoPoint?sellerLocation;
  final orderController = Get.put(CustomerOrderController());



  @override
  Widget build(BuildContext context) {


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
          child: Column(
            children: [
              if (status != "accepted" && status != "completed" && status != "reviewed")
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Left side text
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
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
                              "Distance: ${distance/1000} km "),
                          IconButton(onPressed: () async {
                            int newdistance=0;
                            newdistance =  await showRadiusDialog(context);
                            if(newdistance >0) {
                              orderController.updateDistance(
                                  newdistance, orderId);
                            }

                          }, icon: Icon(CupertinoIcons.add_circled,size: Sizes.md,),)
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
                                            orderController.removeOrder(orderId);
                                            Navigator.of(context).pop(); // Close the dialog
                                          },
                                          child: const Text('Delete'),
                                        ),
                                      ],
                                    );
                                  },
                                );

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


              if (status == "accepted" || status == "completed" || status=="reviewed")
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    // Left side text
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [

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
                              Icons.money,
                              size: Sizes.md,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                             LabelText(title: "Total Price: ${price} Rs"),
                          ],
                        ),
                      ],
                    ),
                    // Right side button
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Row(
                            children: [
                              if(status == "accepted" )
                              Column(
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(10)),
                                    onPressed: () {
                                     showAddressDialog(context,customerLocation!,sellerLocation!);
                                        },
                                    child: Row(

                                      children: [
                                        Icon(CupertinoIcons.location,size: Sizes.md,),
                                        SizedBox(width: 2,),
                                        Text("Location",style: TextStyle(fontSize: Sizes.md),),
                                      ],
                                    ),
                                  ),

                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(10),backgroundColor: Colors.green),
                                    onPressed: () {

                                      final cartRepo=Get.put(CartController());
                                      cartRepo.completeOrder(orderId,sellerId);

                                      //change status to completed
                                      //update time

                                    },
                                    child: Row(
                                      children: [
                                        Icon(CupertinoIcons.check_mark_circled,size: Sizes.md,),
                                        SizedBox(width: 2,),
                                        Text("Complete",style: TextStyle(fontSize: Sizes.fontSizeMd),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                                if(status == "completed")
                                Row(
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(10)),
                                      onPressed: () {
                                        //add a review
                                        _showReviewDialog(context,offer!);

                                      },
                                      child: Row(
                                        children: [
                                          Icon(Icons.rate_review_outlined,size: Sizes.md,),
                                          SizedBox(width: 2,),
                                          Text("Add Review",style: TextStyle(fontSize:12),),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              if(status == "reviewed")
                                Row(
                                  children: [
                                    Icon(Icons.rate_review_outlined,size: Sizes.md,color: Colors.green),
                                    SizedBox(width: 2,),
                                    Text("Reviewed",style: TextStyle(fontSize: Sizes.md,color: Colors.green),),
                                  ],
                                )




                            ],
                          )
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



  void _showReviewDialog(BuildContext context,OfferData offer) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController _reviewController = TextEditingController();
        return AlertDialog(
          title: Text('Add Review'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _reviewController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Enter your review here',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final orderController=Get.put(CustomerOrderController());
                // Handle saving the review here
                String review = _reviewController.text;
                orderController.saveReview( offer, review);

                // Save review to the database or perform any necessary actions
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }


}
