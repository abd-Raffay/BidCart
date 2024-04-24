import 'package:bidcart/const/images.dart';
import 'package:bidcart/const/sizes.dart';
import 'package:bidcart/controllers/seller_controllers/seller_request_controller.dart';
import 'package:bidcart/model/cart_model.dart';
import 'package:bidcart/widget/Text/heading.dart';
import 'package:bidcart/widget/Text/labeltext.dart';
import 'package:bidcart/widget/container/round_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({
    Key? key,
    required this.products,
  }) : super(key: key);

  final List<CartModel> products;

  @override
  Widget build(BuildContext context) {
    final requestController = Get.put(SellerRequestController());
    return AlertDialog(
      titlePadding: const EdgeInsets.all(Sizes.md),
      elevation: 20,
      shadowColor: Colors.black,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(CupertinoIcons.list_bullet),
          const HeadingText(title: "Order Details"),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      content: Container(
        //color: Colors.grey.shade200,
        height: 300,
        width: 300,
        child: Scrollbar(
          interactive: true,
          thumbVisibility: true,
          trackVisibility: true,
          child: ListView.separated(
            itemCount: products.length,
            separatorBuilder: (BuildContext context, int index) {
              return Divider(color: Colors.grey.shade100);
            },
            itemBuilder: (BuildContext context, int index) {
              String availabilityText = requestController.availableProduct(
                          products[index].id, products[index].size) >
                      0
                  ? 'Available: ${requestController.availableProduct(products[index].id, products[index].size)}'
                  : 'Out of stock';
              Color textColor = requestController.availableProduct(products[index].id, products[index].size) > 0 ? Colors.green : Colors.red;
              return GestureDetector(
                onTap: () {},
                child: ListTile(
                  tileColor: Colors.white.withOpacity(0.6),
                  leading: RoundedImage(
                    imageUrl: products[index].image,
                    width: 50, // Adjust the width as needed
                    height: 50, // Adjust the height as needed
                    isNetworkImage: true,
                  ),
                  title: HeadingText(title: products[index].name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const LabelText(title: 'Qty: '),
                          Flexible(
                            child: LabelText(title: products[index].quantity.toString()),
                          ),

                          const LabelText(title: 'Size: '),
                          Flexible(
                            child: LabelText(title: products[index].size),
                          ),
                        ],
                      ),
                      SizedBox(height: 4), // Add some space between subtitles
                      LabelText(title: availabilityText,color: textColor,)
                    ],
                  ),
                ),
              );

            },
          ),
        ),
      ),
    );
  }
}
