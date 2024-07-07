import 'dart:typed_data';
import 'package:bidcart/const/sizes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
import 'package:bidcart/model/location.dart';



void showAddressDialog(BuildContext context,final GeoPoint customerLocation,GeoPoint sellerLocation) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return MapDialog(customerLocation: customerLocation,sellerLocation:sellerLocation );
    },
  );
}

class MapDialog extends StatefulWidget {
  @override
  _MapDialogState createState() => _MapDialogState();

  MapDialog({required this.customerLocation, required this.sellerLocation});

  final GeoPoint customerLocation;
  final GeoPoint sellerLocation;
}

class _MapDialogState extends State<MapDialog> {
  late GoogleMapController mapController;
  final _auth = FirebaseAuth.instance;
  Set<Marker> _markers = {};
  Map<PolylineId,Polyline> polylines = {};




  @override
  void initState() {
    super.initState();
    // Add markers once the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //final GeoPoint userLocation = GeoPoint(33.540953419083706, 73.08073952794075);
      //final GeoPoint sellerLocation = GeoPoint(33.54337789039526, 73.06678600609303);
      await addMarkers();
     final coordinates = await fetchPolylinePoints(widget.customerLocation, widget.sellerLocation);
     generatePolylineFromPoints(coordinates);
    });
  }

  Future<Uint8List> getMarkerIcon(String image, int size) async {
    ByteData data = await rootBundle.load(image);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: size);
    ui.FrameInfo info = await codec.getNextFrame();
    return (await info.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<void> addMarker(String markerId, LatLng location,bool flag) async {
    if(flag ==true)
    {
      final Uint8List newIcon = await getMarkerIcon('assets/logo/storelogo.png', 80);
      var marker = Marker(
        icon: BitmapDescriptor.fromBytes(newIcon),
        markerId: MarkerId(markerId),
        position: location,
      );
      setState(() {
        _markers.add(marker);
      });
    }else{
      var marker = Marker(
        markerId: MarkerId(markerId),
        position: location,
      );
      setState(() {
        _markers.add(marker);
      });
    }


  }

  Future<void> addMarkers() async {
    await addMarker("UserId", LatLng(widget.customerLocation.latitude, widget.customerLocation.longitude),false);
    await addMarker("SellerId", LatLng(widget.sellerLocation.latitude, widget.sellerLocation.longitude),true);
  }


    final LatLng userLocation = LatLng(33.540953419083706, 73.08073952794075);
    final LatLng sellerLocation = LatLng(33.54337789039526, 73.06678600609303);

    Future<List<LatLng>> fetchPolylinePoints(GeoPoint seller, GeoPoint customer) async {
      String googleAPiKey="AIzaSyDSpdhrQfFgeLWGBO4o-dWbv5jF1QYMzfc";
      PolylinePoints polylinePoints = PolylinePoints();
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey: googleAPiKey,
        request: PolylineRequest(
          origin: PointLatLng(customer.latitude, customer.longitude),
          destination: PointLatLng(seller.latitude, seller.longitude),
          mode: TravelMode.driving,
        ),
      );
      if(result.points.isNotEmpty){
        return result.points.map((point)=> LatLng(point.latitude, point.longitude)).toList();
      }
      else {
        return [];
      }
    }

    Future<void> generatePolylineFromPoints(List <LatLng> polylineCoordinates) async{
      const id = PolylineId('polyline');

      final polyline=Polyline(
        polylineId: id,
        color: Colors.cyan,
        points: polylineCoordinates,
        width: 5,
      );
      setState(() {
        polylines[id]=polyline;
      });

    }




  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      title: Row(
        children: [
          Icon(Icons.maps_home_work,size: Sizes.lg,),
          SizedBox(width: 4,),
          Text("Directions to Seller",style: TextStyle(fontSize: Sizes.fontSizeLg),),
        ],
      ),
      content: Container(
        width: double.maxFinite,
        height: 400,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black, // Specify the border color
            width: 2.0, // Specify the border width
          ),
        ),
        child: GoogleMap(
          zoomControlsEnabled: false,
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.customerLocation.latitude, widget.customerLocation.longitude),
            zoom: 14,
          ),
          markers: _markers,
          polylines: Set<Polyline>.of(polylines.values),
          onMapCreated: (controller) {
            mapController = controller;
          },
        ),
      ),

      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(10),backgroundColor: Colors.red[900]),

          child: Text("Close"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}