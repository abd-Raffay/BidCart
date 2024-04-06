import 'package:bidcart/const/sizes.dart';
import 'package:bidcart/controllers/customer_controllers/customer_cart_controller.dart';
import 'package:bidcart/widget/app_bar/appBar.dart';
import 'package:bidcart/widget/app_bar/bottomBar.dart';
import 'package:bidcart/widget/app_bar/cart_actions.dart';
import 'package:bidcart/widget/cart/add_remove_buttons.dart';
import 'package:bidcart/widget/cart/cart_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerCartScreen extends StatelessWidget {
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text("My Cart"),
        actions: [
          Obx(() {
            final cartItems = cartController.cartItems;
            return Visibility(
              visible: cartItems().isNotEmpty,
              child: CartActions(),
            );
          }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.defaultSpace),
        child: Obx(() {
          final cartItems = cartController.cartItems;
          if (cartItems().isEmpty) {
            return const Center(
              child: Text('Cart is empty'),
            );
          } else {
            return ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (_, __) =>
              const SizedBox(height: Sizes.spaceBtwSections),
              itemCount: cartItems().length,
              itemBuilder: (context, index) {
                var item = cartItems()[index];
                return Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        // Delete item from cart
                        cartController.showDeleteDialog(context, item.id, item.size);
                      },
                      icon: const Icon(Icons.close),
                    ),
                    CartItem(
                      image: item.image,
                      title: item.name,
                      size: item.size,
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: AddRemoveButtons(
                          quantity: RxInt(item.quantity),
                          id: item.id,
                          size: item.size,
                        ),
                      ),
                    ),
                    const SizedBox(height: Sizes.spaceBtwItems),
                  ],
                );
              },
            );
          }
        }),
      ),
      bottomNavigationBar: Obx(() {
        final cartItems = cartController.cartItems;
        return Visibility(
          visible: cartItems().isNotEmpty,
          child: const BottomBar(buttontext: 'Send Request',functionality: "sendrequest",),
        );
      }),
    );
  }
}
