import 'dart:typed_data';
import 'package:bidcart/controllers/seller_controllers/seller_signup_controller.dart';
import 'package:bidcart/screens/seller/seller_navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

LatLng currentlocation = LatLng(33.5409533, 73.0807394);
late GoogleMapController mapController;
Map<String, Marker> markers = {};
Uint8List? markericon;
final _auth = FirebaseAuth.instance;

Future<Uint8List> getMarkerIcon(String image, int size) async {
  ByteData data = await rootBundle.load(image);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetHeight: size);
  ui.FrameInfo info = await codec.getNextFrame();
  return (await info.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}

class _MapScreenState extends State<MapScreen> {


  @override
  Widget build(BuildContext context) {
    final signupController = Get.put(SellerSignUpController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Store Location'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              if (currentlocation != null) {
                signupController.setLocation(_auth.currentUser?.uid,GeoPoint(currentlocation.latitude,currentlocation.longitude));
                signupController.location = LatLng(
                  currentlocation.latitude,
                  currentlocation!.longitude,
                );
                Get.offAll(()=> const SellerNavigationBar()); // Go back after saving
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
            addMarker(_auth.currentUser?.uid, location);
          });
        },
        markers: markers.values.toSet(),
      ),
    );
  }

  addMarker(String? markerid, LatLng location) async {
    final Uint8List newIcon = await getMarkerIcon('assets/logo/storelogo.png', 100);
    var marker = Marker(
      icon: BitmapDescriptor.fromBytes(newIcon),
      markerId: MarkerId(markerid!),
      position: location,
      infoWindow: InfoWindow(
        title: "Store Location",
        snippet:
        "Latitude: ${location.latitude}, Longitude: ${location.longitude}",
      ),
      draggable: true,
    );

    markers[markerid] = marker;
    setState(() {

    });
  }
}
