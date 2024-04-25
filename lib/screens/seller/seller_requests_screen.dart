import 'package:bidcart/const/sizes.dart';
import 'package:bidcart/controllers/seller_controllers/seller_request_controller.dart';
import 'package:bidcart/model/request_model.dart';
import 'package:bidcart/widget/app_bar/appBar.dart';
import 'package:bidcart/widget/seller/requestcards.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellerRequestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final requestController = Get.put(SellerRequestController());
    late RxList<RequestData> orderRequests = <RequestData>[].obs;

    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text("Request Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.defaultSpace / 2),
        child: Obx(() {
          orderRequests.assignAll(requestController.getRequests());
          return GestureDetector(
            child: orderRequests.isEmpty
                ? Center(
              child: Text(
                'No request',
                style: TextStyle(fontSize: 18),
              ),
            )
                : ListView.separated(
              itemCount: orderRequests.length,
              separatorBuilder: (BuildContext context, int index) =>
                  SizedBox(height: Sizes.defaultSpace),
              itemBuilder: (BuildContext context, int index) {
                final request = orderRequests[index];

                return SellerRequestCards(
                  requests: request,
                  index: index,
                  total: requestController.totalProducts(index),
                  available: requestController.totalAvailableProducts(index),
                );
              },
            ),
          );

        }),
      ),
    );
  }
}
