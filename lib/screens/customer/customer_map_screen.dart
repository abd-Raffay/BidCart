import 'dart:ffi';
import 'dart:typed_data';
import 'package:bidcart/controllers/customer_controllers/customer_cart_controller.dart';
import 'package:bidcart/controllers/customer_controllers/customer_signup_controller.dart';
import 'package:bidcart/controllers/seller_controllers/seller_signup_controller.dart';
import 'package:bidcart/model/location.dart';
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
  CustomerMapScreen({super.key});

  @override
  State<CustomerMapScreen> createState() => _MapScreenState();

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
}

RxList<Locations> locationList = <Locations>[].obs;
final sellerController = Get.put(SellerSignUpController());
final customersignupController = Get.put(CustomerSignUpController());

class _MapScreenState extends State<CustomerMapScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    setMarkers();
  }

  setMarkers() async {
    locationList.assignAll(await sellerController.getLocations());
    for (int i = 0; i < locationList.length; i++) {
      addMarker(
          locationList[i].sellerid,
          locationList[i],
          LatLng(locationList[i].location.latitude,
              locationList[i].location.longitude));
    }
  }

  getCurrentLocation() async {
    Position position = await customersignupController.deteminePosition();
    widget.currentlocation = LatLng(position.latitude, position.longitude);
    widget.mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(position.latitude, position.longitude), zoom: 14)));
  }

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    return Scaffold(
      appBar: TAppBar(
        title: Text('Select Your Location'),
        showBackArrow: true,
      ),
      body: Stack(children: [
        GoogleMap(
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          initialCameraPosition: CameraPosition(
            target: widget.currentlocation,
            zoom: 14,
          ),
          onCameraMove: (CameraPosition? position) {
            if (widget.currentlocation != position!.target) {
              setState(() {
                widget.currentlocation = position.target;

              });
            }
          },
          onMapCreated: (controller) {
            widget.mapController = controller;
          },
          markers: widget.markers.values.toSet(),
        ),



        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 35),
            child: Image.asset(
              'assets/logo/mapmarker.png',
              height: 55,
              width: 55,
            ),
          ),
        )
      ]),
      bottomNavigationBar: Obx(() {
        final cartItems = cartController.cartItems;
        return Visibility(
          visible: cartItems().isNotEmpty,
          child: BottomBar(
            buttontext: 'Send Request',
            functionality: "sendrequest",
            location: GeoPoint(widget.currentlocation.latitude,
                widget.currentlocation.longitude),
          ),
        );
      }),
    );
  }

  addMarker(String? markerid, Locations data, LatLng location) async {
    final Uint8List newIcon =
        await widget.getMarkerIcon('assets/logo/storelogo.png', 100);
    var marker = Marker(
      icon: BitmapDescriptor.fromBytes(newIcon),
      markerId: MarkerId(markerid!),
      position: location,
      infoWindow: InfoWindow(
        title: data.storename,
        snippet:
            "Latitude: ${data.location.latitude}, Longitude: ${data.location.longitude}",
      ),
    );

    widget.markers[markerid] = marker;
    setState(() {});
  }
}
