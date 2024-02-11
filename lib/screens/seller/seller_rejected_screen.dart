import 'package:bidcart/controllers/seller_controllers/seller_approval_controller.dart';
import 'package:bidcart/repository/authentication/seller_authentication_repository.dart';
import 'package:bidcart/screens/seller/approval_screen.dart';
import 'package:bidcart/screens/seller/seller_login.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';


class RejectionScreen extends StatelessWidget {
  const RejectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 30, right: 30),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Lottie.asset("assets/animations/rejection.json"),
              const SizedBox(height: 20),
              const Text("Failed to Register your Store ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 20),
              const Text(
                  "We regret to inform you that your seller account/store has"
                      " been rejected by our admin team. We appreciate your "
                      "interest in joining our platform, but unfortunately, "
                      "we are unable to approve your application at this time"
                      ". If you have any questions or need further clarification, "
                      "please reach out to our support team for assistance.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Preahvihear",
                    fontWeight: FontWeight.w400,

                  )
              ),
              const SizedBox(
                height: 30,
              ),

              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 200,
                height: 50,


                child: OutlinedButton(

                    onPressed:(){
                      //Get.delete();
                      Get.offAll(()=>ApprovalScreen());
                      },
                      child:
                    const Text("Retry",
                      style: TextStyle(
                        color: Colors.black,

                      ),
                    )),
              ),

              /* SizedBox(height: 50,),
              TextButton(onPressed: ()=>controller.sendVerificationEmail(),
                  child: const Text("Resend Email Link",style: TextStyle(
                      color: Colors.blue
                  ),)
              ),
              const SizedBox(
                height: 30,
              ),*/
              /*TextButton(onPressed:(){
                SellerAuthenticationRepository.instance.logout();
                Navigator.push(context,MaterialPageRoute(builder: (context) =>SLoginPage()));},
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_back,
                        color: Colors.blue,),
                      SizedBox(width:5),
                      Text("Back to login",style: TextStyle(
                          color: Colors.blue
                      ),),
                    ],
                  )
              )*/
            ])),
      ),
    );
  }
}
