import 'package:bidcart/const/sizes.dart';
import 'package:bidcart/controllers/customer_controllers/customer_order_controller.dart';
import 'package:bidcart/model/request_model.dart';
import 'package:bidcart/widget/cart/orderdetails.dart';
import 'package:bidcart/widget/seller/order_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerOrderScreen extends StatefulWidget {
  const CustomerOrderScreen({Key? key}) : super(key: key);

  @override
  State<CustomerOrderScreen> createState() => _CustomerOrderScreenState();
}

class _CustomerOrderScreenState extends State<CustomerOrderScreen> {
  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(CustomerOrderController());
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My Orders",style: TextStyle(fontSize: Sizes.fontSizeLg),textAlign: TextAlign.center,),
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
            children:[
            Obx(() {

              RxList<RequestData> orders = orderController.rxOrderRequests;
              if (orders.isEmpty) {
                return const Center(
                  child: Text('No orders placed'),
                );
              } else {
                return ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    // Build your OrderDetailCard here
                    return GestureDetector(
                      onTap: (){
                        print("I am pressed");
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return OrderDetails(products: orders[index].items,showStock: false,);
                          },
                        );
                      },
                      child: OrderDetailCard(
                        orderId: orderController.rxOrderRequests[index].orderId,
                        totalProucts:orderController.rxOrderRequests[index].items.length.toString(),
                        date: orderController.rxOrderRequests[index].dateTime,
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    // Define the separator widget here
                    return const SizedBox(
                        height: 10); // Example: Adding a SizedBox as separator
                  },
                  itemCount: orderController.rxOrderRequests
                      .length, // Adjust this as needed if you have multiple OrderDetailCard items
                );

              }
            }),

              // Pending Orders


              // Completed Orders
              Container(
                child: const Text("completed"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
