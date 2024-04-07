
import 'package:bidcart/const/sizes.dart';
import 'package:bidcart/controllers/admin_controllers/admin_controller.dart';
import 'package:bidcart/model/seller_model.dart';
import 'package:bidcart/screens/admin/seller_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HorizontalStoreCard extends StatelessWidget {
  const HorizontalStoreCard({
    super.key,
   // required this.storeName,
    //required this.location,
    //required this.Status,
    //required this.storeid,
    //required this.userid,
    required this.tab,
    //required this.dateTime,
    required this.seller, // Add this line
  });

  final SellerModel seller;
  //final String storeName;
 // final String location;
  //final String Status;
  //final String storeid;
  //final String userid;
  final String tab;
  //final Timestamp dateTime;

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.blue;
      case 'blocked':
      case 'deleted':
        return Colors.red;
      case 'approved':
        return Colors.green;
      default:
        return Colors.black; // Default color for other statuses
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'pending':
        return Icons.pending;
      case 'blocked':
        return Icons.block;
      case 'deleted':
        return Icons.delete_forever;
      case 'approved':
        return Icons.check_circle;
      default:
        return Icons.error; // Default icon for other statuses
    }
  }

  @override
  Widget build(BuildContext context) {

    final adminController = Get.put(AdminController());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        children: [
          GestureDetector(
            onTap: (){
              Get.to(SellerDetails(seller: seller));
            },
            child: Container(


              padding:  const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(

                border: Border.all(color: Colors.grey.shade200)

              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // Adjust alignment if necessary
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.store),
                          const SizedBox(width:3),
                          Text(seller.storename,style: const TextStyle(fontSize: Sizes.fontSizeLg),),
                        ],
                      ),

                      Row(
                        children: [
                          Icon(Icons.location_on_rounded,color: Colors.red.shade400,),
                          Text(seller.address,style: const TextStyle(color:  Colors.grey),),
                        ],
                      ),

                      Row(
                        children: [
                          const Icon(Icons.calendar_month),
                          Text(DateFormat('yyyy-MM-dd HH:mm').format(seller.dateTime.toDate())),
                        ],
                      )
                    ],
                  ),
                  // Conditionally display widgets based on isApproved
                  if (tab == "all")
                    Row(
                      children: [
                        Icon(
                          _getStatusIcon(seller.status),
                          color: _getStatusColor(seller.status),
                        ),
                        const SizedBox(width: 8), // Adjust the spacing between icon and text
                        Text(
                          seller.status,
                          style: TextStyle(color: _getStatusColor(seller.status)),
                        ),
                      ],
                    )
                  // Display this if the store is approved
                  else if (tab == "pending")
                    Row(
                      children: [

                        //-------------Approve Button----------------
                        ElevatedButton(
                          onPressed: () {
                            adminController.setStatus(seller.storeId, "approved");
                          },
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              textStyle:
                                  const TextStyle(fontSize: Sizes.fontSizeSm),
                              backgroundColor: Colors.green[600]),
                          child: const Text("Approve"),
                        ),

                        const SizedBox(
                          width: Sizes.spaceBtwItems / 2,
                        ),

                        //-------------------------Delete Button--------------------
                        ElevatedButton(
                          onPressed: () {
                            adminController.setStatus(seller.storeId, "rejected");
                          },
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              textStyle:
                                  const TextStyle(fontSize: Sizes.fontSizeSm),
                              backgroundColor: Colors.red[800]),
                          child: const Text("Delete"),
                        ),
                      ],
                    )

                  else if (tab == "approved")

                    Row(
                      children: [
                        Icon(
                          _getStatusIcon(seller.status),
                          color: _getStatusColor(seller.status),
                        ),
                        const SizedBox(width: 8), // Adjust the spacing between icon and text
                        Text(
                          seller.status,
                          style: TextStyle(color: _getStatusColor(seller.status)),
                        ),
                      ],
                    )
                  else if (tab == "deleted")
                        Row(
                          children: [
                            Icon(
                              _getStatusIcon(seller.status),
                              color: _getStatusColor(seller.status),
                            ),
                            const SizedBox(width: 8), // Adjust the spacing between icon and text
                            Text(
                              seller.status,
                              style: TextStyle(color: _getStatusColor(seller.status)),
                            ),
                          ],
                        )

                  else if (tab == "blocked")
                          Row(
                            children: [
                              Icon(
                                _getStatusIcon(seller.status),
                                color: _getStatusColor(seller.status),
                              ),
                              const SizedBox(width: 8), // Adjust the spacing between icon and text
                              Text(
                                seller.status,
                                style: TextStyle(color: _getStatusColor(seller.status)),
                              ),
                            ],
                          )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10,),
        ],
      ),
    );
  }
}
