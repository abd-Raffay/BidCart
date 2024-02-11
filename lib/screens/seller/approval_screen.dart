import 'package:bidcart/controllers/seller_controllers/seller_approval_controller.dart';
import 'package:bidcart/repository/authentication/seller_authentication_repository.dart';
import 'package:bidcart/screens/seller/seller_login.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';


class ApprovalScreen extends StatelessWidget {
  const ApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SellerApprovalController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 30, right: 30),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Lottie.asset("assets/animations/approval.json"),
              const SizedBox(height: 20),
              const Text("Seller Store Approval Pending ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Preahvihear",
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 20),
              const Text(
                  "Thank you for registering as a seller!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Preahvihear",
                    fontWeight: FontWeight.w400,

                  )
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                  "Your store is currently pending approval. Our team will review your application shortly.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Preahvihear",

                  )
              ),



              const SizedBox(
                height: 30,
              ),
              const Text(
                  "Once approved, you will receive an email confirmation and gain access to your seller dashboard.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Preahvihear",

                  )
              ),

              const SizedBox(
                height: 30,
              ),
              const Text(
                  "Thank you for your patience.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Preahvihear",

                  )
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 200,
                height: 50,


                child: OutlinedButton(onPressed: ()=>controller.manuallyCheckStoreVerificationStatus(),
                    child: const Text("Continue",
                      style: TextStyle(
                        color: Colors.black,

                      ),
                    )),
              ),
              TextButton(
                  onPressed:(){
                    controller.Logout();
                Navigator.push(context,MaterialPageRoute(builder: (context) =>SLoginPage()));
                },
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
              )
            ])),
      ),
    );
  }
}
