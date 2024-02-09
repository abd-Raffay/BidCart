import 'package:bidcart/controllers/mail_verfication_controller.dart';
import 'package:bidcart/screens/customer/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MailVerification extends StatelessWidget {
  const MailVerification({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MailVerificationController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(top: 30 * 5, left: 30, right: 30),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Icon(Icons.email, size: 100),
              const SizedBox(height: 20),
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
                style: TextStyle(
                fontFamily: "Preahvihear",

                )
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                  "If not auto redirected after verification,"
                      " click on the Contine button",
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
              TextButton(onPressed:(){ Navigator.push(context,MaterialPageRoute(builder: (context) =>LoginPage()));},
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
