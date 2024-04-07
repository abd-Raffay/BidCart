import 'package:bidcart/controllers/admin_controllers/admin_controller.dart';
import 'package:bidcart/widget/app_bar/tabBar.dart';
import 'package:bidcart/widget/store/horizontal_store_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoresScreen extends StatelessWidget {
  final AdminController adminController = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(

          bottom: const TTabBar(
            tabs: [
              Tab(child: Text("All")),
              Tab(child: Text("Pending")),
              Tab(child: Text("Approved")),
              Tab(child: Text("Deleted")),
              Tab(child: Text("Blocked")),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
          child: TabBarView(

            children: [

              //All Sellers
              Obx(() {
                final sellers = adminController.allSellers();
                if (sellers.isEmpty) {
                  return const Center(
                    child: Text('No sellers available'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: sellers.length,
                    itemBuilder: (context, index) {
                      final seller = sellers[index];
                      return HorizontalStoreCard(
                        seller: sellers[index],
                        tab: "all",
                      );
                    },
                  );
                }
              }),

              // Content for the "Pending" tab
              Obx(() {
                final pendingSellers = adminController.pendingSellers();
                if (pendingSellers.isEmpty) {
                  return const Center(
                    child: Text('No pending sellers available'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: pendingSellers.length,
                    itemBuilder: (context, index) {
                      final seller = pendingSellers[index];
                      return HorizontalStoreCard(
                        seller: pendingSellers[index],
                        tab: "pending",
                      );
                    },
                  );
                }
              }),

              // Content for the "Approved" tab
              Obx(() {
                final approvedSellers = adminController.approvedSellers();
                if (approvedSellers.isEmpty) {
                  return const Center(
                    child: Text('No approved sellers available'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: approvedSellers.length,
                    itemBuilder: (context, index) {
                      final seller = approvedSellers[index];
                      return HorizontalStoreCard(
                        seller: approvedSellers[index],
                        tab: "all",
                      );
                    },
                  );
                }
              }),

              //Deleted Sellers
              Obx(() {
                final deletedSellers = adminController.deletedSellers();
                if (deletedSellers.isEmpty) {
                  return const Center(
                    child: Text('No Deleted sellers available'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: deletedSellers.length,
                    itemBuilder: (context, index) {
                      final seller = deletedSellers[index];
                      return HorizontalStoreCard(
                        seller: deletedSellers[index],
                        tab: "all",
                      );
                    },
                  );
                }
              }),

              //Blocked Sellers
              Obx(() {
                final blockedSellers = adminController.blockedSellers();
                if (blockedSellers.isEmpty) {
                  return const Center(
                    child: Text('No Blocked sellers available'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: blockedSellers.length,
                    itemBuilder: (context, index) {
                      final seller = blockedSellers[index];
                      return HorizontalStoreCard(
                        seller: blockedSellers[index],
                        tab: "all",
                      );
                    },
                  );
                }
              }),

            ],
          ),
        ),
      ),
    );
  }
}
