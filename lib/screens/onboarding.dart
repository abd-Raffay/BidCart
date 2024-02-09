import 'package:flutter/material.dart';
import 'package:bidcart/screens/customer/login.dart';


class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(

          decoration:const BoxDecoration(
        image: DecorationImage(
          image:AssetImage('assets/images/onboarding.jpg'),
          fit: BoxFit.fill,
        )),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(padding: EdgeInsets.only(top:10.0)),
              const SizedBox(height: 100,),
              const Center(
                child: Image(
                  image: AssetImage("assets/images/white_logo.png"),
                ),
              ),
              const Text(
                "Welcome to\n   BidCart",
                style: TextStyle(
                  fontFamily: "Preahvihear",
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Text(
                "Get your groceries in cheap",
                style: TextStyle(
                  fontFamily: "Preahvihear",
                  fontSize: 14,
                  color: Colors.white,

                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom:250.0)),

              Container(

                child: ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder:(_)=> LoginPage() ,
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0BBFDC),
                    fixedSize: const Size(350, 20),
                    elevation: 10,
                  ),
                    child:const Text("Get Started",style: TextStyle(
                      fontFamily: "Preahvihear",
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              GestureDetector(onTap:(){
                  print("Signup Page");
                },
                child:Center(
                    child:Text("continue as a Seller",style: TextStyle(
                      fontFamily: "Preahvihear",
                      fontSize: 14,

                      color: Colors.white,
                     // fontWeight: FontWeight.bold,
                      decoration: TextDecoration.combine([
                          TextDecoration.underline,
                          TextDecoration.underline]),

                      decorationColor: Colors.white,
                      decorationThickness: 3.0,
                      
                    ))
                ),)

            ],
          )






      )
    );
  }
}
