import 'package:bidcart/const/images.dart';
import 'package:bidcart/const/sizes.dart';
import 'package:bidcart/widget/app_bar/bottomBar.dart';
import 'package:bidcart/widget/cart/add_remove_buttons.dart';
import 'package:bidcart/widget/container/round_image.dart';
import 'package:bidcart/widget/products/product_text/product_label_text.dart';
import 'package:bidcart/widget/products/product_text/product_title_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Modal extends StatefulWidget {
  Modal({
    Key? key,
    required this.image,
    required this.title,
    required this.id,
    required this.sizes,
    required this.quantity,

  }) : super(key: key);

  final String image;
  final String title;
  final String id;
  final int quantity;
  final List<String> sizes;

  @override
  State<Modal> createState() => _ModalState();
}

class _ModalState extends State<Modal> {
  String? size;

  @override
  Widget build(BuildContext context) {
    String? dropdownValue = widget.sizes.first;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.spaceBtwItems,
              horizontal: Sizes.spaceBtwItems / 2,
            ),
            child: Column(
              children: [
                // Your modal content
                Row(
                  children: [
                    // Photo on the left
                    SizedBox(
                      child: RoundedImage(
                        imageUrl: widget.image,
                        height: 150,
                        width: 150,
                        isNetworkImage: true,
                      ),
                    ),
                    const SizedBox(width: Sizes.spaceBtwItems),

                    // Column for title and dropdown
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title aligned to the right of the photo
                          TitleText(title: widget.title),

                          const SizedBox(height: Sizes.spaceBtwSections),

                          // Dropdown below the title
                          DropdownMenu(
                            width: 170,
                            label: const Text(
                              "Select Size",
                              style: TextStyle(fontSize: Sizes.fontSizeSm),
                            ),
                            menuStyle: MenuStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                              surfaceTintColor: MaterialStateProperty.all(Colors.white),
                            ),
                            onSelected: (String? value) {
                              setState(() {
                                dropdownValue = value;
                                size=dropdownValue;

                              });
                              // This is called when the user selects an item.

                              //print(dropdownValue);
                            },
                            dropdownMenuEntries: widget.sizes
                                .map<DropdownMenuEntry<String>>((String value) {
                              return DropdownMenuEntry<String>(value: value, label: value);
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                AddRemoveButtons(quantity: RxInt(widget.quantity),id: widget.id,size: size.toString()),
                Expanded(child: Container()),

                // BottomBar placed at the bottom with padding
                BottomBar(buttontext: 'Add this Item',productId: widget.id,size:size,functionality: "add"),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ],
      ),
    );
  }
}
