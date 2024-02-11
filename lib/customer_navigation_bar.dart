import 'package:bidcart/screens/customer/customer_account_screen.dart';
import 'package:bidcart/screens/customer/customer_cart.dart';
import 'package:bidcart/screens/customer/customer_explore_screen.dart';
import 'package:bidcart/screens/customer/customer_favourite.dart';
import 'package:bidcart/screens/customer/customer_homescreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerNavigationBar extends StatelessWidget {
  const CustomerNavigationBar({super.key});


  @override
  Widget build(BuildContext context) {

    final controller=Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar: Obx(
        ()=> NavigationBar(
          backgroundColor: Colors.white,
          indicatorColor: Colors.cyan.shade50,
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,

          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), label: "Home"),
            NavigationDestination(icon: Icon(Icons.explore_outlined), label: "Explore"),
            NavigationDestination(icon: Icon(Icons.shopping_cart_outlined), label: "Cart"),
            NavigationDestination(icon: Icon(Icons.favorite_outline_outlined), label: "Favourite"),
            NavigationDestination(icon: Icon(Icons.account_balance_outlined), label: "Account"),
          ],
        ),
      ),
      body: Obx(
              ()=>
      controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController{
  final Rx<int> selectedIndex = 0.obs;

  final screens=[
   const CustomerScreen(),
    const CustomerExploreScreen(),
    const CustomerCartScreen(),
    const CustomerFavouriteScreen(),
    const CustomerAccountScreen(),
  ];
}