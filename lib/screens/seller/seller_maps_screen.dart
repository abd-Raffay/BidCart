import 'dart:typed_data';
import 'package:bidcart/controllers/customer_controllers/customer_signup_controller.dart';
import 'package:bidcart/controllers/seller_controllers/seller_signup_controller.dart';
import 'package:bidcart/model/location.dart';
import 'package:bidcart/screens/seller/seller_navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

import '../customer/customer_map_screen.dart';

class MapScreen extends StatefulWidget {
   MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();


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

RxList<Location> locationList=<Location>[].obs;

final sellerController=Get.put(SellerSignUpController());
final customersignupController = Get.put(CustomerSignUpController());

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();
    // Your initialization code here
    getCurrentLocation();
    setMarkers();
  }

  setMarkers() async {
    locationList.assignAll(await sellerController.getLocations());
    for(int i=0;i<locationList.length;i++) {
      addMarker(locationList[i].sellerid,locationList[i], LatLng(locationList[i].location.latitude, locationList[i].location.longitude));
    }
  }

  getCurrentLocation()  async {
  Position position = await customersignupController.deteminePosition();
  widget.currentlocation=LatLng(position.latitude, position.longitude);
  widget.mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 14)));
 // markers.clear();
  //addMarker(widget._auth.currentUser!.uid, LatLng(position.latitude, position.longitude));
  }





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
              //signupController.setLocation(widget._auth.currentUser?.uid,GeoPoint(widget.currentlocation.latitude,widget.currentlocation.longitude));
            signupController.saveLocation(GeoPoint(widget.currentlocation.latitude, widget.currentlocation.longitude));
            print(widget.currentlocation);
              Get.offAll(()=> const SellerNavigationBar()); // Go back after saving
                        },
          ),
        ],
      ),
      body: Stack(
        children: [GoogleMap(
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          initialCameraPosition: CameraPosition(
            target: widget.currentlocation,
            zoom: 14,
          ),
          onCameraMove: (CameraPosition? position){
            if(widget.currentlocation != position!.target){
              setState(() {
                widget.currentlocation=position.target;
                signupController.saveLocation(GeoPoint(widget.currentlocation.latitude, widget.currentlocation.longitude));
                print(widget.currentlocation);
                //addMarker(widget._auth.currentUser?.uid, currentlocation);

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
              padding:  const EdgeInsets.only(bottom: 35),
              child: Image.asset('assets/logo/mapmarker.png',
              height: 55,
                  width: 55,)
              ,
            ),
          )
    ]),
    );
  }

  addMarker(String? markerid,Location data, LatLng location) async {
    final Uint8List newIcon = await widget.getMarkerIcon('assets/logo/storelogo.png', 100);
    var marker = Marker(
      icon: BitmapDescriptor.fromBytes(newIcon),
      markerId: MarkerId(markerid!),
      position: location,
      infoWindow: InfoWindow(
        title: data.storename,
        snippet: "Latitude: ${data.location.latitude}, Longitude: ${data.location.longitude}",
      ),
    );

    widget.markers[markerid] = marker;
    setState(() {

    });

  }

}
