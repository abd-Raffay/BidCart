import 'dart:async';

import 'package:bidcart/screens/seller/seller_add_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ConnectivityCheck extends StatefulWidget {
  const ConnectivityCheck({Key? key}) : super(key: key);

  @override
  State<ConnectivityCheck> createState() => _ConnectivityCheckState();
}

class _ConnectivityCheckState extends State<ConnectivityCheck> {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen(_updateConnectionStatus as void Function(List<ConnectivityResult> event)?) as StreamSubscription<ConnectivityResult>;
    initConnectivity();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    ConnectivityResult result = (await Connectivity().checkConnectivity()) as ConnectivityResult;
    _updateConnectionStatus(result);
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        navigateToNextScreen(); // Navigate to next screen on successful connection
      });
    }
  }

  void navigateToNextScreen() {
    Get.offAll(()=>  SellerAddScreen()); // Example using GetX navigation to navigate to '/next_screen'
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged.transform(StreamTransformer.fromHandlers(
          handleData: (data, sink) {
            sink.add(data.last);
          },
        )),
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
              return const Center(
                child: Text("Connected to internet"),
              );
            } else {
              // Not connected to internet
              return noInternet();
            }
          }
        },
      ),
    );
  }

  Widget loading() {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan),
      ),
    );
  }

  Widget noInternet() {
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
              style: TextStyle(fontSize: 20, fontFamily: "Roboto"),
            ),
            ElevatedButton(
              onPressed: () async {
                await initConnectivity(); // Refresh connectivity status
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 20),
                ),
              ),
              child: const Text("Refresh"),
            ),
          ],
        ),
      ),
    );
  }
}
