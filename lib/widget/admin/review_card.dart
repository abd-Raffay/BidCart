import 'package:bidcart/widget/Text/heading.dart';
import 'package:bidcart/widget/Text/labeltext.dart';
import 'package:bidcart/widget/admin/reviews.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../const/sizes.dart';
import '../../model/review_model.dart';
import 'orderdetails.dart';

class ReviewCard extends StatelessWidget {
  final Review review;

  ReviewCard({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      width: MediaQuery.of(context).size.width,
      child: Card(
        color: Colors.white,
        shadowColor: Colors.black,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              // Left Side Data
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.store),
                        const SizedBox(width: 2),
                        Expanded(child: HeadingText(title: review.offer.sellerName)),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(Icons.person),
                        const SizedBox(width: 2),
                        Expanded(child: HeadingText(title: review.customerName)),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(Icons.money),
                        const SizedBox(width: 2),
                        Expanded(child: LabelText(title: "${review.offer.totalPrice.toString()} Rs", color: Colors.black)),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(Icons.date_range),
                        const SizedBox(width: 2),
                        Expanded(child: LabelText(title: review.reviewDateTime, color: Colors.black)),
                      ],
                    ),
                  ],
                ),
              ),
              // Right Side Data
            Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(10)),
                        onPressed: () {
                          showReviewDialog(context, review);
                        },
                        child: Row(
                          children: [
                            Icon(Icons.rate_review_outlined,size: Sizes.iconSm,),
                            SizedBox(width: 2,),
                            const Text("View Review",style:TextStyle(fontSize: Sizes.fontSizeSm),),
                          ],
                        ),
                      ),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(10)),
                        onPressed: () {
                          showOrderDialog(context, review.offer); // Show cart dialog
                        },
                        child: Row(
                          children: [
                            Icon(Icons.shopping_cart,size: Sizes.iconSm,),
                            SizedBox(width: 2,),
                            const Text("View Order",style:TextStyle(fontSize: Sizes.fontSizeSm),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

            ],
          ),
        ),
      ),
    );
  }
}