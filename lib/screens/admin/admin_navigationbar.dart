import 'package:bidcart/screens/admin/admin_reviews_screen.dart';
import 'package:bidcart/screens/admin/admin_stores_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminNavigationBar extends StatelessWidget {
  const AdminNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          backgroundColor: Colors.transparent,
          indicatorColor: Colors.cyan.shade50,
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.store_sharp), label: "Stores"),
            NavigationDestination(
                icon: Icon(Icons.rate_review_outlined),
                label: "Reviews"),

          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
     StoresScreen(),
    const ReviewsScreen(),
  ];
}
