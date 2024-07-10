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
    final orderController = Get.put(SellerOfferController());


    return DefaultTabController(
        length: 2, // Number of tabs
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Order Requests',
              style: TextStyle(fontSize: Sizes.fontSizeLg),
              textAlign: TextAlign.center,
            ),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Pending Requests'),
                Tab(text: 'Completed Requests'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // Tab 1: Pending Requests
              Obx(() {
                final pendingRequests = requestController.getPendingRequests();
                if (pendingRequests.isEmpty) {
                  return Center(
                    child: Text(
                      'No Order Requests',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: pendingRequests.length,
                    itemBuilder: (BuildContext context, int index) {
                      final request = pendingRequests[index];
                      return SellerRequestCards(
                        requests: request,
                        total: request.items.length,
                        totalavailable:requestController.totalAvailableProducts(request.orderId!),
                      );
                    },
                  );
                }
              }),

              // Tab 2: Completed Requests
              Obx(() {
                final completedRequests = requestController.getCompletedRequests();
                if (completedRequests.isEmpty) {
                  return const Center(
                    child: Text('No sellers available'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: completedRequests.length,
                    itemBuilder: (BuildContext context, int index) {
                      final request = completedRequests[index];
                      return SellerRequestCards(
                        requests: request,
                        total: request.items.length,
                        totalavailable: requestController.totalAvailableProducts(request.orderId!),



                      );
                    },
                  );
                }
              }),

            ],
          ),

          floatingActionButton: FloatingActionButton(
            onPressed: () {
              requestController.getOrderStatus();
            },
            tooltip: 'Refresh',
            child: const Icon(Icons.refresh),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation
              .endFloat, // Adjust as per your preference
        ));
  }
}
