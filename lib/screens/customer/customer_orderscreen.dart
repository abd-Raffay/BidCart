import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bidcart/controllers/customer_controllers/customer_order_controller.dart';
import 'package:bidcart/model/request_model.dart';
import 'package:bidcart/widget/cart/orderdetails.dart';
import 'package:bidcart/widget/seller/order_details.dart';
import 'package:bidcart/const/sizes.dart';

class CustomerOrderScreen extends StatefulWidget {
  const CustomerOrderScreen({Key? key}) : super(key: key);

  @override
  State<CustomerOrderScreen> createState() => _CustomerOrderScreenState();
}

class _CustomerOrderScreenState extends State<CustomerOrderScreen> {
  final orderController = Get.put(CustomerOrderController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "My Orders",
            style: TextStyle(fontSize: Sizes.fontSizeLg),
            textAlign: TextAlign.center,
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Pending"),
              Tab(text: "Completed"),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TabBarView(
            children: [
              // Pending Orders Tab
              Obx(() {
                final orders = orderController.rxOrderRequests;
                if (orders.where((p0) => p0.status == "null").isEmpty) {
                  return const Center(
                    child: Text('No Orders Were Placed.'),
                  );
                } else {
                  return ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      final order = orders[index];
                      if (order.status == "null") {
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return OrderDetails(
                                  products: order.items,
                                  showStock: false,
                                );
                              },
                            );
                          },
                          child: OrderDetailCard(
                            status: order.status,
                            orderId: order.orderId!,
                            totalProducts: order.items.length,
                            date: order.dateTime,
                            height: 110,// Ensure date format is correct
                          ),
                        );
                      }
                      return Container(); // Return empty container if condition not met
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 10);
                    },
                    itemCount: orders.length,
                  );
                }
              }),

              // Completed Orders Tab
              Obx(() {
                final orders = orderController.rxOrderRequests;
                if (orders.isEmpty) {
                  return const Center(
                    child: Text('No completed orders'),
                  );
                } else {
                  return ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      final order = orders[index];
                      if (order.status == "accepted") {
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return OrderDetails(
                                  products: order.items,
                                  showStock: false,
                                );
                              },
                            );
                          },
                          child: OrderDetailCard(
                            status: order.status,
                            orderId: order.orderId!,
                            totalProducts: order.items.length,
                            date: order.dateTime,
                            height: 140,// Ensure date format is correct
                          ),
                        );
                      }
                      return Container(); // Return empty container if condition not met
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 10);
                    },
                    itemCount: orders.length,
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
