import 'package:bidcart/const/sizes.dart';
import 'package:bidcart/model/seller_model.dart';
import 'package:bidcart/widget/Text/heading.dart';
import 'package:bidcart/widget/app_bar/appBar.dart';
import 'package:bidcart/widget/app_bar/block.dart';
import 'package:bidcart/widget/store/label_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SellerDetails extends StatelessWidget {
  SellerDetails({
    super.key,
    required this.seller,

  });
  SellerModel seller;

 IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'blocked':
        return Icons.block;
      case 'rejected':
        return Icons.cancel;
      case 'pending':
        return Icons.pending;
      case 'approved':
        return Icons.check_circle;
      default:
        return Icons.info;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'blocked':
        return Colors.red;
      case 'rejected':
        return Colors.red.shade800;
      case 'pending':
        return Colors.orange;
      case 'approved':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: const HeadingText(title: 'Seller Details',),
        showBackArrow: true,
        actions: [
          BlockSeller(storeId: seller.storeId,status:RxString(seller.status),)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.symmetric(vertical: Sizes.spaceBtwItems),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 237, 237, 237),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Icon(Icons.sell_outlined, color: Colors.grey),
                      SizedBox(
                        width: Sizes.spaceBtwItems / 3,
                      ),
                      Text(
                        'Seller Information',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Sizes.fontSizeLg,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Sizes.spaceBtwItems),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.blue.shade900,
                                ),
                                const Text(
                                  'Name',
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: Sizes.fontSizeMd),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4.0),
                             LabelText(title: seller.sellername,)

                          ],
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.email,
                                  color: Colors.red.shade900,
                                ),
                                const Text(
                                  'Email',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4.0),
                            LabelText(title: seller.email,)
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Sizes.spaceBtwItems),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: Colors.green.shade500,
                                ),
                                const Text(
                                  'Phone',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4.0),
                            LabelText(title: seller.phone,)
                          ],
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.credit_card,
                                  color: Colors.yellow.shade600,
                                ),
                                const Text(
                                  'CNIC',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4.0),
                            LabelText(title: seller.cnic,)
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Sizes.spaceBtwItems * 2),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.symmetric(vertical: Sizes.spaceBtwItems),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 237, 237, 237),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.storefront,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: Sizes.spaceBtwItems / 2,
                      ),
                      Text(
                        'Store Information',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Sizes.fontSizeLg,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: Sizes.spaceBtwItems/2),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                
                                Icon(
                                  Icons.drive_file_rename_outline,
                                  color: Colors.grey.shade800,
                                ),
                                const Text(
                                  'Store Name',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),

                            LabelText(title: seller.storename,)
                          ],
                        ),
                      ),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.red.shade600,
                                ),
                                const Text(
                                  'Store Address',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4.0),
                            LabelText(title: seller.address,)
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: Sizes.spaceBtwItems/2),
                   Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(
                                  Icons.date_range,
                                  color: Colors.blue,
                                ),
                                Text(
                                  'Date of Registration',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            LabelText(title: DateFormat('yyyy-MM-dd HH:mm').format(seller.dateTime.toDate()),),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.inventory,
                                      color: Colors.brown,
                                    ),
                                    Text(
                                      'Inventory',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              'Inventory ke feild dalni hy',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: Sizes.spaceBtwItems/2,),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.money,
                                  color: Colors.green.shade800,
                                ),
                                const Text(
                                  'Sales',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const Text(
                              'Sales dalni hyy',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.discount,
                                  color: Colors.red,
                                ),
                                Text(
                                  'Discount',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(height: 4.0),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: Sizes.spaceBtwItems/2),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: Sizes.spaceBtwItems),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow.shade800,
                                ),
                                const Text(
                                  'Rating',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4.0),
                            const Text(
                              'rating dalni hyy',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                             _getStatusIcon(seller.status),
                             color: _getStatusColor(seller.status),
                                ),
                            Text(
                              seller.status,
                              style: TextStyle(
                                fontSize: 16.0,
                                  color: _getStatusColor(seller.status)
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

