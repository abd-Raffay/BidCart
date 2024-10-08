import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/customer_controllers/customer_navigation_controller.dart';


class CustomerNavigationBar extends StatelessWidget {
  final Rx<int>? index;

  CustomerNavigationBar({Key? key, this.index}) : super(key: key);

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
          selectedIndex: (index?.value == 2) ? index!.value : controller.selectedIndex.value,
          onDestinationSelected: (int newIndex) {
            if (index == 2) {
              index!.value = newIndex;
            } else {
              controller.selectedIndex.value = newIndex;
            }
          },
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.home_outlined), label: "Home"),
            NavigationDestination(
                icon: Icon(Icons.explore_outlined), label: "Explore"),
            NavigationDestination(
                icon: Icon(Icons.shopping_bag_outlined), label: "Order"),
            NavigationDestination(
                icon: Icon(Icons.account_balance_outlined), label: "Account"),
          ],
        ),
      ),
      body: Obx(() {
        print(index?.value);
        if (index?.value == 2) {
          return controller.screens[index!.value];
        } else {
          return controller.screens[controller.selectedIndex.value];
        }
      }),
    );
  }
}
