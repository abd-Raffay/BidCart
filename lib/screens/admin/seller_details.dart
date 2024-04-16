import 'package:bidcart/const/sizes.dart';
import 'package:bidcart/model/seller_model.dart';
import 'package:bidcart/widget/app_bar/appBar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SellerDetails extends StatelessWidget {
  SellerDetails({
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
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text("Seller Details"),
        ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(

                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.symmetric(vertical:Sizes.spaceBtwItems,horizontal: Sizes.spaceBtwItems),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,

                  borderRadius: BorderRadius.circular(8.0),
                ),
                child:  Column(
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.sell_outlined,color: Colors.grey),
                        SizedBox(width: Sizes.spaceBtwItems/3,),
                        Text(
                          'Seller Information',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Sizes.fontSizeLg,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height:Sizes.spaceBtwItems),

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
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                seller.sellername,
                                style: const TextStyle(fontSize: Sizes.md),
                              ),
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
                              Text(
                                seller.email,
                                style: const TextStyle(fontSize: Sizes.fontSizeMd),
                              ),
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
                              Text(
                                seller.phone,
                                style: const TextStyle(fontSize: 16.0),
                              ),
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
                              Text(
                                seller.cnic,
                                style: const TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Sizes.spaceBtwItems*2),

                    Row(
                      children: [
                        Icon(Icons.storefront,color: Colors.grey,),
                        SizedBox(width: Sizes.spaceBtwItems/2,),
                        const Text(
                          'Store Information',
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
                                    Icons.store,
                                    color: Colors.grey.shade800,
                                  ),
                                  Text(
                                    'Store Name',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                seller.storename,
                                style: TextStyle(fontSize: Sizes.fontSizeMd),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16.0),
                        
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
                                style: TextStyle(fontSize: 16.0,color: _getStatusColor(seller.status)),
                              ),
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
                                    Icons.date_range,
                                    color: Colors.blue,
                                  ),
                                  Text(
                                    'Date of Registration',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),

                              Text(
                                DateFormat('yyyy-MM-dd HH:mm:ss').format(seller.dateTime.toDate() ),
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
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
                    const SizedBox(height: 10),
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
                                    Icons.location_on,
                                    color: Colors.red.shade600,
                                  ),
                                  Text(
                                    'Store Address',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                seller.address,
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: Sizes.spaceBtwItems),
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
                                  Text(
                                    'Rating',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                'rating dalni hyy',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
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
                                  Text(
                                    'Sales',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),

                              Text(
                                'Sales dalni hyy',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
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
                    const SizedBox(
                      height: 10,
                    ),


                  ],
                ),
              ),

              Expanded(child: Container()),
              ElevatedButton(onPressed: () {},style:ElevatedButton.styleFrom(backgroundColor: Colors.red.shade400) , child: Center(
                child: Row(
                  children: [
                    Icon(Icons.block),
                    const Text('Block This User'),
                  ],
                ),
              ),)

            ],
          ),

        ),
      ),
    );
  }
}
