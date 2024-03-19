import 'package:bidcart/controllers/common_controllers/forget_password_controller.dart';
import 'package:bidcart/screens/customer/customer_login.dart';
import 'package:bidcart/screens/seller/seller_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ResetPassword extends StatelessWidget {


  const ResetPassword({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(CustomerMailVerificationController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              SizedBox(
                  height:300,
                  width: 300,

                  child: Lottie.asset("assets/animations/Email_loading.json")),
              //const SizedBox(height: 20),
              Text(email,
                textAlign: TextAlign.center,),
              const Text("Password Reset Email Sent",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 20),
              const Text(
                "Your Account Security is Our Priority Wehave sent you a Secure Link to Safetly Change Your Password and Keep Your Account Protected",
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(

                    onPressed: () {
                      Get.offAll(()=> CustomerLoginPage());
                    },
                    child: const Text(
                      "Done",
                      style: TextStyle(

                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30,),
              TextButton(onPressed: (){
                ForgetPasswordController.instance.resendPasswordResetEmail(email);
              },
                  child: const Text("Resend Email",style: TextStyle(
                    color: Colors.black
                  ),)
              ),
              const SizedBox(
                height: 30,
              ),
            ])),
      ),
    );
  }
}
