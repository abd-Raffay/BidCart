import 'package:bidcart/const/images.dart';
import 'package:bidcart/const/sizes.dart';
import 'package:bidcart/controllers/customer_controllers/customer_home_controller.dart';
import 'package:bidcart/widget/app_bar/appBar.dart';
import 'package:bidcart/widget/app_bar/bottomBar.dart';
import 'package:bidcart/widget/cart/add_remove_buttons.dart';
import 'package:bidcart/widget/container/round_image.dart';
import 'package:bidcart/widget/products/product_text/product_label_text.dart';
import 'package:bidcart/widget/products/product_text/product_title_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({
    super.key, required this.imageUrl, required this.title, required this.description, required this.size, required this.category});

  final String imageUrl;
  final String title;
  final String description;
  final String size;
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
                  title: size,
                  fontsize: Sizes.md,
                ),

                const SizedBox(
                  height: Sizes.defaultSpace,
                ),
                //const AddRemoveButtons(),

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


