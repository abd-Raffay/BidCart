import 'package:bidcart/screens/seller/seller_add_screen.dart';
import 'package:bidcart/screens/seller/requests_screen.dart';
import 'package:bidcart/screens/seller/seller_account_screen.dart';
import 'package:bidcart/screens/seller/seller_homescreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellerNavigationBar extends StatelessWidget {
  const SellerNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SellerNavigationController());
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          backgroundColor: Colors.white,
          indicatorColor: Colors.cyan.shade50,
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.home_outlined), label: "Home"),
            NavigationDestination(
                icon: Icon(Icons.developer_board), label: "Request"),
            NavigationDestination(icon: Icon(Icons.add), label: "Add"),
            NavigationDestination(
                icon: Icon(Icons.account_balance_outlined), label: "Account"),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class SellerNavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
     SellerHomeScreen(),
    const SellerRequestScreen(),
    const SellerAddScreen(),
    const SellerAccountScreen(),
  ];
}
