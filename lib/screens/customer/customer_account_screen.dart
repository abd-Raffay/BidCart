import 'package:bidcart/controllers/customer_controllers/customer_account_controller.dart';
import 'package:bidcart/controllers/customer_controllers/customer_signin_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const/sizes.dart';

class CustomerAccountScreen extends StatelessWidget {
  const CustomerAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accountController = Get.put(CustomerAccountController());

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Center(
              child:const Text('My Profile'),

            ),
          ],
        ),
      ),
      body: Obx(() {
        // Check if customer data is available
        if (accountController.customer.value.id == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final customer = accountController.customer.value;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Profile Information',
                      style: TextStyle(fontSize: Sizes.fontSizeLg),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.person),
                            SizedBox(width: 8),
                            Text('Name'),
                          ],
                        ),
                        Text(customer.name),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.location_on),
                            SizedBox(width: 8),
                            Text('Location'),
                          ],
                        ),
                        Text(customer.address),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Personal Information',
                      style: TextStyle(fontSize: Sizes.fontSizeLg),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.badge),
                            SizedBox(width: 8),
                            Text('User ID'),
                          ],
                        ),
                        Text(customer.id),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.email),
                            SizedBox(width: 8),
                            Text('E-mail'),
                          ],
                        ),
                        Text(customer.email),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.phone),
                            SizedBox(width: 8),
                            Text('Phone number'),
                          ],
                        ),
                        Text(customer.phone),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  accountController.logout();
                },
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(10)),
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
