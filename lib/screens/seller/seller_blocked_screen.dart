import 'package:bidcart/const/sizes.dart';
import 'package:bidcart/controllers/seller_controllers/seller_approval_controller.dart';
import 'package:bidcart/repository/authentication/seller_authentication_repository.dart';
import 'package:bidcart/screens/seller/seller_login.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

class SellerBlockScreen extends StatelessWidget {
  const SellerBlockScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SellerApprovalController());

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset("assets/animations/blocked.json"),
            const SizedBox(height: 20),
            const Text(
              "Account Blocked",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Your store/account has been blocked.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Please contact customer support for assistance.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              "You will not be able to access your seller dashboard until the issue is resolved.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: 200,
              height: 50,
              child: OutlinedButton(
                onPressed: () {
                  // Perform action on button press
                },
                child: const Text(
                  "Contact Support",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                controller.Logout();
                Get.back();
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_back,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Back to login",
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
