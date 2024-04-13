
import 'package:bidcart/const/sizes.dart';
import 'package:bidcart/widget/app_bar/appBar.dart';
import 'package:bidcart/widget/seller/requestcards.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SellerRequestScreen extends StatelessWidget {
  //final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text("Request Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.defaultSpace/2),
        child:Column(
          children: [
            SellerRequestCards(userName: "Ali",date: "11-12-2000 12:00 pm"),
          ],
        )
      )
    );
  }
}
