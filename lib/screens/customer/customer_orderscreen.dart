

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
      length: 3,
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
              Tab(text:"Reviewed"),
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
                            distance: order.distance,
                            height: 110,
                            price: order.price,
                            sellerId: order.sellerId!,// Ensure date format is correct
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

                      return FutureBuilder<void>(
                        future: orderController.getOffers(order.orderId!),
                        builder: (BuildContext context, AsyncSnapshot<void> offersSnapshot) {
                          if (offersSnapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (offersSnapshot.hasError) {
                            return Center(child: Text('Error fetching offers'));
                          } else {
                            // Once offers are fetched, get the specific offer for the seller
                            OfferData? offer = orderController.getOffer(order.sellerId!);

                            if (order.status == "accepted" || order.status == "completed" ) {
                              return GestureDetector(
                                onTap: () {},
                                child: FutureBuilder<int>(
                                  future: orderController.getDistance(order.orderId!, order.sellerId!),
                                  builder: (BuildContext context, AsyncSnapshot<int> distanceSnapshot) {
                                    if (distanceSnapshot.connectionState == ConnectionState.waiting) {
                                      return Center(child: CircularProgressIndicator());
                                    } else if (distanceSnapshot.hasError) {
                                      return Center(child: Text('Error calculating distance'));
                                    } else if (distanceSnapshot.hasData) {
                                      return FutureBuilder<String>(
                                        future: orderController.getLocation(order.orderId!, order.sellerId!),
                                        builder: (BuildContext context, AsyncSnapshot<String> addressSnapshot) {
                                          if (addressSnapshot.connectionState == ConnectionState.waiting) {
                                            return Center(child: CircularProgressIndicator());
                                          } else if (addressSnapshot.hasError) {
                                            return Center(child: Text('Error fetching address'));
                                          } else if (addressSnapshot.hasData) {
                                            // Fetch customer location separately
                                            return FutureBuilder<GeoPoint>(
                                              future: orderController.getSellerLocation(order.sellerId!),
                                              builder: (BuildContext context, AsyncSnapshot<GeoPoint> customerLocationSnapshot) {
                                                if (customerLocationSnapshot.connectionState == ConnectionState.waiting) {
                                                  return Center(child: CircularProgressIndicator());
                                                } else if (customerLocationSnapshot.hasError) {
                                                  return Center(child: Text('Error fetching customer location'));
                                                } else if (customerLocationSnapshot.hasData) {
                                                  return OrderDetailCard(
                                                    status: order.status,
                                                    distance: distanceSnapshot.data!,
                                                    address: addressSnapshot.data!, // Pass address to OrderDetailCard
                                                    orderId: order.orderId!,
                                                    totalProducts: order.items.length,
                                                    date: order.dateTime,
                                                    height: 140,
                                                    price: order.price,
                                                    sellerId: order.sellerId!,
                                                    sellerLocation: customerLocationSnapshot.data!,
                                                    customerLocation: order.location,
                                                    offer: offer, // Use fetched offer data if needed
                                                  );
                                                } else {
                                                  return Container();
                                                }
                                              },
                                            );
                                          } else {
                                            return Container();
                                          }
                                        },
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                              );
                            } else {
                              return Center(child: Container(child: Text("No Completed Orders"))); // Return empty container if condition not met
                            }
                          }
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) => Divider(),
                    itemCount: orders.length,
                  );
                }
              }),

              //Reviewed Orders
              Obx(() {
                final orders = orderController.rxOrderRequests;
                if (orders.isEmpty) {
                  return const Center(
                    child: Text('No Reviewed orders'),
                  );
                } else {
                  return ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      final order = orders[index];

                      return FutureBuilder<void>(
                        future: orderController.getOffers(order.orderId!),
                        builder: (BuildContext context, AsyncSnapshot<void> offersSnapshot) {
                          if (offersSnapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (offersSnapshot.hasError) {
                            return Center(child: Text('Error fetching offers'));
                          } else {
                            // Once offers are fetched, get the specific offer for the seller
                            OfferData? offer = orderController.getOffer(order.sellerId!);

                            if (order.status == "reviewed") {
                              return GestureDetector(
                                onTap: () {},
                                child: FutureBuilder<int>(
                                  future: orderController.getDistance(order.orderId!, order.sellerId!),
                                  builder: (BuildContext context, AsyncSnapshot<int> distanceSnapshot) {
                                    if (distanceSnapshot.connectionState == ConnectionState.waiting) {
                                      return Center(child: CircularProgressIndicator());
                                    } else if (distanceSnapshot.hasError) {
                                      return Center(child: Text('Error calculating distance'));
                                    } else if (distanceSnapshot.hasData) {
                                      return FutureBuilder<String>(
                                        future: orderController.getLocation(order.orderId!, order.sellerId!),
                                        builder: (BuildContext context, AsyncSnapshot<String> addressSnapshot) {
                                          if (addressSnapshot.connectionState == ConnectionState.waiting) {
                                            return Center(child: CircularProgressIndicator());
                                          } else if (addressSnapshot.hasError) {
                                            return Center(child: Text('Error fetching address'));
                                          } else if (addressSnapshot.hasData) {
                                            // Fetch customer location separately
                                            return FutureBuilder<GeoPoint>(
                                              future: orderController.getSellerLocation(order.sellerId!),
                                              builder: (BuildContext context, AsyncSnapshot<GeoPoint> customerLocationSnapshot) {
                                                if (customerLocationSnapshot.connectionState == ConnectionState.waiting) {
                                                  return Center(child: CircularProgressIndicator());
                                                } else if (customerLocationSnapshot.hasError) {
                                                  return Center(child: Text('Error fetching customer location'));
                                                } else if (customerLocationSnapshot.hasData) {
                                                  return OrderDetailCard(
                                                    status: order.status,
                                                    distance: distanceSnapshot.data!,
                                                    address: addressSnapshot.data!, // Pass address to OrderDetailCard
                                                    orderId: order.orderId!,
                                                    totalProducts: order.items.length,
                                                    date: order.dateTime,
                                                    height: 140,
                                                    price: order.price,
                                                    sellerId: order.sellerId!,
                                                    sellerLocation: customerLocationSnapshot.data!,
                                                    customerLocation: order.location,
                                                    offer: offer, // Use fetched offer data if needed
                                                  );
                                                } else {
                                                  return Container();
                                                }
                                              },
                                            );
                                          } else {
                                            return Container();
                                          }
                                        },
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                              );
                            } else {
                              return Container(); // Return empty container if condition not met
                            }
                          }
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) => Divider(),
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
