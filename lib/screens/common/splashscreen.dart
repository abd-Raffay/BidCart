import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bidcart/screens/common/onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
with SingleTickerProviderStateMixin{

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(Duration(seconds: 2),(){
       Navigator.of(context).pushReplacement(MaterialPageRoute(
           builder:(_)=> const OnBoarding() ,
           ));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    overlays: SystemUiOverlay.values);


    super.dispose();

  }



   Widget build(BuildContext context) {
     return Scaffold(
       body:Container(child: const Center(
         child: Image(
           image: AssetImage("assets/images/logo.png")
         ),
         ),
       )

     );

   }
 }
