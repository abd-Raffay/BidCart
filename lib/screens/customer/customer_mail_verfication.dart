import 'package:bidcart/controllers/customer_controllers/customer_mail_verfication_controller.dart';
import 'package:bidcart/repository/authentication/customer_authentication_repository.dart';
import 'package:bidcart/screens/customer/customer_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CustomerMailVerification extends StatelessWidget {
  const CustomerMailVerification({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerMailVerificationController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
            child: Column(mainAxisSize: MainAxisSize.min,
                children: [
              SizedBox(
                  height:300,
                  width: 300,

                child: Lottie.asset("assets/animations/Email_loading.json")),
              //const SizedBox(height: 20),
              const Text("Verify your email Address",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Preahvihear",
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 20),
              const Text(
                "We have just send email verfication link"
                    " on your email. Please check mail and"
                    " click on that link to verify you Email Address.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                  "If not auto redirected after verification,"
                      " click on the Contine button",
                  textAlign: TextAlign.center,
                  style: TextStyle(


                  )
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 200,
                height: 50,


                child: OutlinedButton(onPressed: ()=>controller.manuallyCheckEmailVerificationStatus(),
                    child: const Text("Continue",
                      style: TextStyle(


                        color: Colors.black,

                      ),
                )),
                ),

              const SizedBox(height: 50,),
              TextButton(onPressed: ()=>controller.sendVerificationEmail(),
                  child: const Text("Resend Email Link",style: TextStyle(
                      color: Colors.blue
                  ),)
              ),
              const SizedBox(
                height: 30,
              ),
              TextButton(onPressed:(){
                Get.offAll(()=> CustomerLoginPage());
                CustomerAuthenticationRepository.instance.logout();
                //Navigator.push(context,MaterialPageRoute(builder: (context) =>CustomerLoginPage()));
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
