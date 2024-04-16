import 'package:bidcart/const/sizes.dart';
import 'package:bidcart/controllers/common_controllers/forget_password_controller.dart';
import 'package:bidcart/widget/app_bar/appBar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: const TAppBar(showBackArrow: true),
      body: SingleChildScrollView( // Wrap with SingleChildScrollView
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.spaceBtwItems,
            horizontal: Sizes.spaceBtwItems,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 300,
                  width: 300,
                  child: Lottie.asset("assets/animations/lock.json"),
                ),
              ),
              const Text(
                "Forget Password",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: Sizes.spaceBtwItems),
              const Text(
                "Don't worry sometimes people can forget too, enter your email and we will send you a password reset link.",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: Sizes.spaceBtwItems),
              Form(
                key: controller.forgetPasswordFormKey,
                child: TextFormField(
                  controller: controller.email,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2.0, color: Colors.cyan),
                    ),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!EmailValidator.validate(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: Sizes.spaceBtwItems),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    controller.sendPasswordResetEmail();
                  },
                  child: const Text("Submit"),
                ),
              ),
              const SizedBox(height: Sizes.spaceBtwItems), // Add space at the bottom
            ],
          ),
        ),
      ),
    );
  }
}
