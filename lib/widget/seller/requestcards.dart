import 'package:bidcart/const/sizes.dart';
import 'package:bidcart/controllers/seller_controllers/seller_request_controller.dart';
import 'package:bidcart/model/request_model.dart';
import 'package:bidcart/widget/Text/labeltext.dart';
import 'package:bidcart/widget/seller/order_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellerRequestCards extends StatelessWidget {
  const SellerRequestCards({
    Key? key,
    required this.requests,
    required this.index,
    required this.total,
    required this.available,
  }) : super(key: key);

  final RequestData requests;
  final int index;
  final int total;
  final int available;

  @override
  Widget build(BuildContext context) {
    final requestController = Get.put(SellerRequestController());

    return GestureDetector(
      onTap: () async {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return OrderDetails(products: requests.items);
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 100,
        width: MediaQuery.of(context).size.width,
        foregroundDecoration: BoxDecoration(color: Colors.grey.withOpacity(0.1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

               Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person),
                      SizedBox(width: 5),
                      Text(requests.customerName),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.date_range_outlined),
                      SizedBox(width: 5),
                      Text(requests.dateTime),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(CupertinoIcons.cart),
                      SizedBox(width: 5),
                      Text("Product Available: $available/$total"),
                    ],
                  ),
                ],
              ),


            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    if (available != null && available != 0) // Render buttons only if available is not null and not 0
                      ElevatedButton(
                        onPressed: () {
                          // Handle accept action
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          textStyle: const TextStyle(fontSize: Sizes.fontSizeSm),
                          backgroundColor: Colors.green[600],
                        ),
                        child: const Text("Accept"),
                      ),
                    if (available != null && available != 0) // Render spacing only if available is not null and not 0
                      const SizedBox(width: 8),
                    if (available != null && available != 0) // Render buttons only if available is not null and not 0
                      ElevatedButton(
                        onPressed: () {
                          // Handle reject action
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          textStyle: const TextStyle(fontSize: Sizes.fontSizeSm),
                          backgroundColor: Colors.red[600],
                        ),
                        child: const Text("Reject"),
                      ),
                    if (available == 0) // Render "No products to sell" message if available is null or 0
                      LabelText(title: "No Products to Sell",color: Colors.red,)
                  ],
                ),
              ],
            ),



          ],
        ),
      ),
    );
  }
}
