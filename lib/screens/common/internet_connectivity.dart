
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

class ConnectivityCheck extends StatelessWidget {
  const ConnectivityCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: StreamBuilder<ConnectivityResult>(
          stream: Connectivity().onConnectivityChanged.expand((results) => results),
          builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show loading
              return loading();
            } else if (!snapshot.hasData) {
              // No data available yet
              return const Center(
                child: Text('No data available yet'),
              );
            } else {
              ConnectivityResult result = snapshot.data!;
              if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
                // Connected to mobile data or wifi
                // Here, you would navigate back to the previous route
                //Get.back();
                return const Text("Connected to internet");
              } else {
                // Not connected to internet
                // Store the current route and navigate to NoInternetScreen

                return noInternet();
              }
            }
          },
        ),
      ),
    );
  }

  Widget loading(){
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan),
      ),
    );
  }
  Widget noInternet(){
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: Lottie.asset("assets/animations/no_internet_animation.json"),
            ),
            const SizedBox(height: 20),
            const Text(
              "No Internet Connection",
              style: TextStyle(fontSize: 20,fontFamily: "Roboto"),
            ),
            ElevatedButton(onPressed: () async{

              ConnectivityResult result = (await Connectivity().checkConnectivity()) as ConnectivityResult;
              print(result.toString());

            },
            style: const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 20))), child: const Text("Refresh"),)
          ],
        ),
      ),
    );
  }
}
