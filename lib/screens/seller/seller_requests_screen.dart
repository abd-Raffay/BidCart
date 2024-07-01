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

    late RxList<RequestData> orderRequests = <RequestData>[].obs;

    return DefaultTabController(
        length: 2, // Number of tabs
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Order Requests'),
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
                List<RequestData> pendingRequests = requestController
                    .rxOrderRequests
                    .where((request) => request.status == 'null')
                    .toList();
                return pendingRequests.isEmpty
                    ? const Center(
                        child: Text(
                          'No Pending Requests',
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    : ListView.builder(
                        itemCount: pendingRequests.length,
                        itemBuilder: (BuildContext context, int index) {
                          final request = pendingRequests[index];
                          return SellerRequestCards(
                            status: request.status,
                            requests: request,
                            total: request.items.length,
                            available:
                                requestController.totalAvailableProducts(index),
                          );
                        },
                      );
              }),
              // Tab 2: Completed Requests
              Obx(() {
                List<RequestData> completedRequests = requestController
                    .rxOrderRequests
                    .where((request) => request.status == 'accepted')
                    .toList();
                return completedRequests.isEmpty
                    ? const Center(
                        child: Text(
                          'No Completed Requests',
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    : ListView.builder(
                        itemCount: completedRequests.length,
                        itemBuilder: (BuildContext context, int index) {
                          final request = completedRequests[index];
                          return SellerRequestCards(
                            status: request.status,
                            requests: request,
                            total: request.items.length,
                            available:
                                requestController.totalAvailableProducts(index),
                          );
                        },
                      );
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
