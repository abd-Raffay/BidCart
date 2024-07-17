import 'package:bidcart/model/offer_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
                final orders = orderController.rxOrderRequests
                    .where((order) =>
                order.status != "accepted" &&
                    order.status != "completed" &&
                    order.status != "reviewed")
                    .toList();

                if (orders.isEmpty) {
                  return Center(
                    child: Text('No Orders'),
                  );
                } else {
                  return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      final order = orders[index];
                      // Once offers are fetched, get the specific offer for the seller
                      OfferData? offer = orderController.getOffer(order.sellerId!);
                      return FutureBuilder<int>(
                        future: orderController.getDistance(order.orderId!,
                            order.sellerId!, order.sellerLocation!),
                        builder: (BuildContext context,
                            AsyncSnapshot<int> distanceSnapshot) {
                          if (distanceSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container(
                              height: 140, // Adjust height as needed
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else if (distanceSnapshot.hasError) {
                            return Container(
                              height: 140, // Adjust height as needed
                              child: Center(
                                child: Text('Error fetching distance'),
                              ),
                            );
                          } else {
                            int distance = distanceSnapshot.data!;
                            return GestureDetector(
                              onTap: () {},
                              child: Container(
                                child: OrderDetailCard(
                                  status: order.status,
                                  distance: order.distance,
                                  orderId: order.orderId!,
                                  totalProducts: order.items.length,
                                  date: order.dateTime,
                                  sellerLocation: order.location,
                                  height: 140,
                                  price: order.price,
                                  sellerId: order.sellerId!,
                                  customerLocation: order.location,
                                  offer:
                                  offer, // Use fetched offer data if needed
                                ),
                              ),
                            );
                          }
                        },
                      );
                    },
                    itemCount: orders.length,
                  );
                }
              }),

              //Reviewed Orders
              Obx(() {
                final orders = orderController.rxOrderRequests.where((order) =>
                order.status == "reviewed" ||
                    order.status == "accepted" ||
                    order.status == "completed")
                    .toList();

                if (orders.isEmpty) {
                  return Center(
                    child: Text('Complete an order'),
                  );
                } else {
                  return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      final order = orders[index];
                      print(order.orderId);

                      return FutureBuilder<List<OfferData>>(
                        future: orderController.getOffersNew(order.orderId!),
                        builder: (BuildContext context, AsyncSnapshot<List<OfferData>> offersSnapshot) {
                          if (offersSnapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (offersSnapshot.hasError) {
                            return Center(child: Text('Error fetching offers'));
                          } else {
                            List<OfferData>? offers = offersSnapshot.data;
                            print(offers);
                            OfferData? offer = offers?.isNotEmpty == true ? offers!.first : null; // Assuming you want the first offer
                            print(offer?.orderId);
                            return FutureBuilder<int>(
                              future: orderController.getDistance(order.orderId!, order.sellerId!, order.sellerLocation!),
                              builder: (BuildContext context, AsyncSnapshot<int> distanceSnapshot) {
                                if (distanceSnapshot.connectionState == ConnectionState.waiting) {
                                  return Container(
                                    height: 140, // Adjust height as needed
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                } else if (distanceSnapshot.hasError) {
                                  return Container(
                                    height: 140, // Adjust height as needed
                                    child: Center(
                                      child: Text('Error fetching distance'),
                                    ),
                                  );
                                } else {
                                  int distance = distanceSnapshot.data!;
                                  return GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      child: OrderDetailCard(
                                        status: order.status,
                                        distance: distance,
                                        orderId: order.orderId!,
                                        totalProducts: order.items.length,
                                        date: order.dateTime,
                                        height: 140,
                                        price: order.price,
                                        sellerId: order.sellerId!,
                                        customerLocation: order.location,
                                        offer: offer,
                                        // Use fetched offer data if needed
                                        sellerLocation: order.sellerLocation, // Corrected to use order.sellerLocation
                                      ),
                                    ),
                                  );
                                }
                              },
                            );
                          }
                        },
                      );
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
