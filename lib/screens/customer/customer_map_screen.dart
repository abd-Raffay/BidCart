import 'dart:ffi';
import 'dart:typed_data';
import 'package:bidcart/controllers/customer_controllers/customer_cart_controller.dart';
import 'package:bidcart/controllers/customer_controllers/customer_signup_controller.dart';
import 'package:bidcart/controllers/seller_controllers/seller_signup_controller.dart';
import 'package:bidcart/widget/app_bar/appBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

import '../../widget/app_bar/bottomBar.dart';

class CustomerMapScreen extends StatefulWidget {
  const CustomerMapScreen({super.key});

  @override
  State<CustomerMapScreen> createState() => _MapScreenState();
}

LatLng currentlocation = LatLng(33.5409533, 73.0807394);
late GoogleMapController mapController;
Map<String, Marker> markers = {};
Uint8List? markericon;
final _auth = FirebaseAuth.instance;

class _MapScreenState extends State<CustomerMapScreen> {
  @override
  Widget build(BuildContext context) {
    final signupController = Get.put(SellerSignUpController());
    final cartController = Get.put(CartController());
    final customersignupController = Get.put(CustomerSignUpController());
    return Scaffold(
      appBar: TAppBar(
        title: Text('Select Your Location'),
        showBackArrow: true,
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              if (currentlocation != null) {
                signupController.setLocation(
                    _auth.currentUser?.uid,
                    GeoPoint(
                        currentlocation.latitude, currentlocation.longitude));
                signupController.location = LatLng(
                  currentlocation.latitude,
                  currentlocation!.longitude,
                );
                //Navigator.pop(context); // Go back after saving
              } else {
                // Show a message or alert that location is not selected
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please select a location')),
                );
              }
            },
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: currentlocation,
          zoom: 14,
        ),
        onMapCreated: (controller) {
          mapController = controller;
        },
        onTap: (location) {
          setState(() {
            currentlocation = location;
            addMarker("selected_marker", location);
          });
        },
        markers: markers.values.toSet(),
      ),
      bottomNavigationBar: Obx(() {
        final cartItems = cartController.cartItems;
        return Visibility(
          visible: cartItems().isNotEmpty,
          child: BottomBar(
            buttontext: 'Send Request',
            functionality: "sendrequest",
            location:
                GeoPoint(currentlocation.latitude, currentlocation.longitude),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Position position = await customersignupController.deteminePosition();
          mapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 14)));
          markers.clear();
          addMarker(_auth.currentUser!.uid, LatLng(position.latitude, position.longitude));
        },
        label: Text("Current Location"),
        icon: Icon(Icons.location_history),
      ),
    );
  }

  addMarker(String markerid, LatLng location) async {
    var marker = Marker(
      markerId: MarkerId(markerid),
      position: location,
      infoWindow: InfoWindow(
        title: "Store Location",
        snippet:
            "Latitude: ${location.latitude}, Longitude: ${location.longitude}",
      ),
      draggable: true,
    );

    markers[markerid] = marker;
    setState(() {});
  }
}
