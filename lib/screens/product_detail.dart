import 'package:bidcart/const/images.dart';
import 'package:bidcart/const/sizes.dart';
import 'package:bidcart/controllers/customer_controllers/customer_home_controller.dart';
import 'package:bidcart/widget/app_bar/appBar.dart';
import 'package:bidcart/widget/app_bar/bottomBar.dart';
import 'package:bidcart/widget/container/round_image.dart';
import 'package:bidcart/widget/products/product_text/product_label_text.dart';
import 'package:bidcart/widget/products/product_text/product_title_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({
    super.key, required this.imageUrl, required this.title, required this.description, required this.quantity, required this.category});

  final String imageUrl;
  final String title;
  final String description;
  final String quantity;
  final String category;



  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(CustomerHomeController());
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text("Product Details"),
      ),
      bottomNavigationBar: const BottomBar(buttontext: 'Add to Cart',),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                //- Product Image
                SizedBox(
                    height: 300,
                    child: RoundedImage(
                      imageUrl: imageUrl,
                      isNetworkImage: true,
                      height: 200,
                    )),
                const SizedBox(
                  height: Sizes.defaultSpace,
                ),
                const RoundedImage(
                  imageUrl: Images.split,
                  isNetworkImage: false,
                ),
                const SizedBox(
                  height: Sizes.defaultSpace,
                ),

                ProductTitleText(
                  title: title,
                  textAlign: TextAlign.left,
                  fontSize: 24,
                ),
                ProductLabelText(
                  title: quantity,
                  fontsize: Sizes.md,
                ),

                const SizedBox(
                  height: Sizes.defaultSpace,
                ),

                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {},
                        child: const Icon(CupertinoIcons.minus)),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: Colors.grey)),
                      child: const SizedBox(
                          height: 32 * 1.8, width: 32 * 2, child: Text("2")),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        child: const Icon(CupertinoIcons.add)),
                  ],
                ),
                const SizedBox(
                  height: Sizes.defaultSpace,
                ),

                const RoundedImage(
                  imageUrl: Images.split,
                  isNetworkImage: false,
                ),

                const SizedBox(
                  height: Sizes.defaultSpace,
                ),
                const Text(
                  "Description",
                  style: TextStyle(fontSize: 24.0),
                ),
                const SizedBox(
                  height: Sizes.defaultSpace/2,
                ),
                Text(description,style: const TextStyle(color: Colors.grey),),
              ]),
        ),
      ),
    );
  }
}


