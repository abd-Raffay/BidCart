import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controllers/seller_controllers/seller_account_controller.dart';

class SellerAccountScreen extends StatelessWidget {
  const SellerAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accountController = Get.put(SellerAccountController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Obx(() {
        // Add loading indicator while fetching data
        if (accountController.seller.value.userId == null) {
          return const Center(child: CircularProgressIndicator());
        }
        final seller = accountController.seller.value;
        DateTime dateTime = seller.dateTime.toDate();

        // Format the DateTime object to d/M/y
        final DateFormat formatter = DateFormat('d/M/y');
        final String formattedDate = formatter.format(dateTime);

        // Once data is fetched, display it
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 234, 234, 234),
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Profile Information',
                      style: TextStyle(fontSize: 25),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.person, color: Colors.blue),
                            SizedBox(width: 8),
                            Text('Name'),
                          ],
                        ),
                        Text(seller.sellername),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.store, color: Colors.green),
                            SizedBox(width: 8),
                            Text('Store name'),
                          ],
                        ),
                        Text(seller.storename),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.credit_card, color: Color.fromARGB(255, 176, 159, 0)),
                            SizedBox(width: 8),
                            Text('CNIC'),
                          ],
                        ),
                        Text(seller.cnic),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.location_on, color: Color.fromARGB(255, 0, 36, 60)),
                            SizedBox(width: 8),
                            Text('Location'),
                          ],
                        ),
                        Text(seller.location.longitude.toString()),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 234, 234, 234),
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Personal Information',
                      style: TextStyle(fontSize: 25),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.badge, color: Color.fromARGB(255, 0, 150, 153)),
                            SizedBox(width: 8),
                            Text('User ID'),
                          ],
                        ),
                        Text(seller.userId),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.phone, color: Color.fromARGB(255, 213, 100, 19)),
                            SizedBox(width: 8),
                            Text('Phone number'),
                          ],
                        ),
                        Text(seller.phone),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.email, color: Color.fromARGB(255, 52, 39, 234)),
                            SizedBox(width: 8),
                            Text('Email'),
                          ],
                        ),
                        Text(seller.email),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.verified, color: Color.fromARGB(255, 13, 221, 134)),
                            SizedBox(width: 8),
                            Text('Status'),
                          ],
                        ),
                        Text(seller.status),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.calendar_today, color: Color.fromARGB(255, 143, 192, 20)),
                            SizedBox(width: 8),
                            Text('Date of Registration'),
                          ],
                        ),
                        Text(formattedDate),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  accountController.logout();
                },
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
              ),
            ],
          ),
        );
      }),
    );
  }
}
