import 'package:bidcart/const/images.dart';
import 'package:bidcart/widget/app_bar/appBar.dart';
import 'package:bidcart/widget/app_bar/cart_counter_icon.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const TAppBar(
          showBackArrow: false,
          leadingIcon: Images.logo,
          title: Text("BidCart"),
          actions: [CartCounterIcon()],
        ),
        body: Container(
          child: Text("apsssple"),
        ));
  }
}
