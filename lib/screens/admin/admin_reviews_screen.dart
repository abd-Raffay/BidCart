import 'package:bidcart/controllers/admin_controllers/admin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../widget/admin/appBar.dart';
import '../../widget/admin/review_card.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final adminController=Get.put(AdminController());
    return Scaffold(
      appBar: AdminAppBar(
        title: Text("Reviews"),
      ),
      body:Obx(() {
       if (adminController.reviews.isEmpty) {
          return Center(child: Text('No reviews found.'));
        } else {
          return ListView.builder(
            padding: EdgeInsets.all(10.0),
            itemCount: adminController.reviews.length,
            itemBuilder: (context, index) {
              final review = adminController.reviews[index];
              return ReviewCard(review: review);
            },
          );
        }
      }),
    );
  }
}
