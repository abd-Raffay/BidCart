import 'package:bidcart/const/sizes.dart';
import 'package:bidcart/controllers/customer_controllers/customer_order_controller.dart';
import 'package:bidcart/widget/Text/heading.dart';
import 'package:bidcart/widget/Text/labeltext.dart';
import 'package:bidcart/widget/bids/bid_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/app_bar/appBar.dart';

class BidScreen extends StatefulWidget {
  int totalProducts;
  String orderid;
   BidScreen({
     required this.totalProducts,
    required this.orderid,
    super.key});

  @override
  State<BidScreen> createState() => _BidScreenState();
}

class _BidScreenState extends State<BidScreen> {
  final orderController = Get.put(CustomerOrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text("BIDS"),
      ),
      body: Obx(
            () {
          if (orderController.rxorderOffers == null || orderController.rxorderOffers.isEmpty) {
            return const Center(
              child: Text("No bids placed"),
            );
          }
          return ListView.builder(
            itemCount: orderController.rxorderOffers.length,
            itemBuilder: (context, index) {
              final offer = orderController.rxorderOffers[index];
              return BidCard(
                offer: offer,
                totalproducts: widget.totalProducts,
              ); // Replace with your BidCard widget
            },
          );
        },
      ),

        floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(widget.orderid);
          orderController.getOffers(widget.orderid);
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
