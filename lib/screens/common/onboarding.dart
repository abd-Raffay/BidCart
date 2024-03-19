import 'package:bidcart/const/images.dart';
import 'package:bidcart/screens/common/reset_password.dart';
import 'package:bidcart/screens/seller/seller_login.dart';
import 'package:bidcart/screens/seller/seller_signup.dart';
import 'package:flutter/material.dart';
import 'package:bidcart/screens/customer/customer_login.dart';
import 'package:get/get.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Images.onBoarding),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.only(top: 10.0)),
            const SizedBox(height: 100),
            const Center(
              child: Image(
                image: AssetImage(Images.whiteLogo),
              ),
            ),
            const Text(
              "Welcome to\n   BidCart",
              style: TextStyle(

                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Text(
              "Get your groceries in cheap",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 250.0)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: SizedBox(
                  width: double.infinity,
                child: ElevatedButton(

                  onPressed: () {
                    Get.offAll(()=> CustomerLoginPage());
                    //Navigator.of(context).pushReplacement(MaterialPageRoute(
                     // builder: (_) => ResetPassword(),
                   // )
                   // );

                  },
                  child: const Text(
                    "Get Started",
                    style: TextStyle(

                      color: Colors.white,
                      fontWeight: FontWeight.w400,


                    ),
                  ),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 10)),
            TextButton(
                onPressed: (){
                  //Navigator.of(context).pushReplacement(MaterialPageRoute(
                    // builder: (_) => SLoginPage()));
                  Get.offAll(()=> SLoginPage() );
                },
                child: Text(
                  "continue as a Seller",
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.combine([
                      TextDecoration.underline,
                      TextDecoration.underline,
                    ]),
                    decorationColor: Colors.white,
                    decorationThickness: 3.0,
                  ),
                ),),


          ],
        ),
      ),
    );
  }
}
