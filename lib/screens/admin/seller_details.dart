import 'package:bidcart/const/sizes.dart';
import 'package:bidcart/model/seller_model.dart';
import 'package:bidcart/widget/app_bar/appBar.dart';
import 'package:bidcart/widget/store/label_text.dart';
import 'package:bidcart/widget/store/title_texts.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SellerDetails extends StatelessWidget {
  const SellerDetails({super.key, required this.seller});

  final SellerModel seller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const TAppBar(
          showBackArrow: true,
          title: Text("Store Details"),
        ),
        body: Container(

            padding: const EdgeInsets.symmetric(horizontal: 20),
            child:  Column(
                children: [

                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.store),
                            const SizedBox(width: Sizes.spaceBtwItems),
                            const TitleText(title: "Store Name: "),
                            LabelText(title:seller.storename),
                          ],
                        ),
                        const SizedBox(width: Sizes.spaceBtwItems),
                        Row(
                          children: [
                            const Icon(Icons.location_on),
                            const SizedBox(width: Sizes.spaceBtwItems),
                            const TitleText(title: "Address: "),
                            LabelText(title:seller.address),
                          ],
                        ),
                        const SizedBox(width: Sizes.spaceBtwItems),
                        Row(
                          children: [
                            const Icon(Icons.email),
                            const SizedBox(width: Sizes.spaceBtwItems),
                            const TitleText(title: "Email: "),
                            LabelText(title:seller.email),
                          ],
                        ),
                        const SizedBox(width: Sizes.spaceBtwItems),
                        Row(
                          children: [
                            const Icon(Icons.person),
                            const SizedBox(width: Sizes.spaceBtwItems),
                            const TitleText(title: "Owner Name: "),
                            LabelText(title:seller.sellername),

                          ],
                        ),
                        const SizedBox(width: Sizes.spaceBtwItems),
                        Row(
                          children: [
                            const Icon(Icons.phone),
                            const SizedBox(width: Sizes.spaceBtwItems),
                            const TitleText(title: "Phone No#: "),
                            LabelText(title:seller.phone),
                          ],
                        ),
                        const SizedBox(width: Sizes.spaceBtwItems),
                        Row(
                          children: [
                            const Icon(Icons.credit_card),
                            const SizedBox(width: Sizes.spaceBtwItems),
                            const TitleText(title: "CNIC: "),
                            LabelText(title:seller.cnic),
                          ],
                        ),
                        const SizedBox(width: Sizes.spaceBtwItems),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today),
                            const SizedBox(width: Sizes.spaceBtwItems),
                            const TitleText(title: "Date Created: "),
                            LabelText(title:DateFormat('yyyy-MM-dd HH:mm').format(seller.dateTime.toDate())),
                          ],
                        ),
                        const SizedBox(width: Sizes.spaceBtwItems),
                        Row(
                          children: [
                            const Icon(Icons.info),
                            const SizedBox(width: Sizes.spaceBtwItems),
                            const TitleText(title: "Status: "),
                            LabelText(title:seller.status),
                          ],
                        ),
                      ],
                    ),
                  )

                ]
            )
        )
    );
  }
}
