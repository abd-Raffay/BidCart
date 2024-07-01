import 'package:bidcart/const/sizes.dart';
import 'package:bidcart/controllers/seller_controllers/seller_offer_controller.dart';
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
    final orderController=Get.put(SellerOfferController());

    late RxList<RequestData> orderRequests = <RequestData>[].obs;

    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text("Request Screen"),
      ),
      body: Obx(() {
        orderRequests.assignAll(requestController.rxOrderRequests);
        return GestureDetector(
          child: orderRequests.isEmpty
              ? const Center(
                  child: Text(
                    'No Order requests',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : ListView.builder(
                  itemCount: orderRequests.length,
                  itemBuilder: (BuildContext context, int index) {
                    final request = orderRequests[index];

                    return SellerRequestCards(
                      status: orderRequests[index].status,
                      requests: request,
                      //index: index,
                      total: orderRequests[index].items.length,
                      available:
                          requestController.totalAvailableProducts(index),

                    );
                  },
                ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          requestController.getOrderStatus();

        },
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .endFloat, // Adjust as per your preference
    );
  }
}
