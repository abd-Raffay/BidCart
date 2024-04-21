import 'package:bidcart/const/images.dart';
import 'package:bidcart/const/sizes.dart';
import 'package:bidcart/controllers/customer_controllers/customer_cart_controller.dart';
import 'package:bidcart/widget/app_bar/appBar.dart';
import 'package:bidcart/widget/app_bar/bottomBar.dart';
import 'package:bidcart/widget/app_bar/cart_counter_icon.dart';
import 'package:bidcart/widget/container/round_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetail extends StatefulWidget {
  ProductDetail({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.size,
    required this.category,
    required this.id,
    required this.quantity,
  });

  final String id;
  final String imageUrl;
  final String title;
  final String description;
  final List<String> size;
  final String category;
  final int quantity;

  String? sizee;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  String? dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.size.first;
  }

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(widget.title),
        actions: const [
          CartCounterIcon(),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Product Image
                RoundedImage(
                  imageUrl: widget.imageUrl,
                  isNetworkImage: true,
                  height: 200,
                ),
                const RoundedImage(
                  imageUrl: Images.split,
                  isNetworkImage: false,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: Sizes.spaceBtwItems),
                    DropdownMenu(
                      width: 170,
                      label: const Text(
                        " Select Size",
                        style: TextStyle(fontSize: Sizes.fontSizeSm),
                      ),
                      menuStyle: MenuStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        surfaceTintColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      onSelected: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue = value!;
                        });

                        widget.sizee = dropdownValue;
                        //print(dropdownValue);
                      },
                      dropdownMenuEntries: widget.size
                          .map<DropdownMenuEntry<String>>((String value) {
                        return DropdownMenuEntry<String>(
                            value: value, label: value);
                      }).toList(),
                    ),
                  ],
                ),

                const Text(
                  "Description",
                  style: TextStyle(fontSize: Sizes.fontSizeLg),
                ),
                const SizedBox(
                  height: Sizes.defaultSpace / 2,
                ),
                Text(
                  widget.description,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 8), // Added SizedBox for spacing
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(
        size: widget.sizee,
        productId: widget.id,
        quantity: cartController.getQuantity(widget.id),
        buttontext: 'Add to Cart',
        functionality: "add",
      ),
    );
  }
}
