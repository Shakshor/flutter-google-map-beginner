import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetUserCurrentLocationScreen extends StatefulWidget {
  const GetUserCurrentLocationScreen({super.key});

  @override
  State<GetUserCurrentLocationScreen> createState() => _GetUserCurrentLocationScreenState();
}

class _GetUserCurrentLocationScreenState extends State<GetUserCurrentLocationScreen> {


  // google map instance
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  // initial camera position
  static const CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 14,
  );

  // marker
  final List<Marker> _markers = <Marker> [

    Marker(
      markerId: MarkerId('1'),
      position: LatLng(37.42796133580664, -122.085749655962),
      infoWindow: InfoWindow(
        title: 'The title of the marker'
      )
    )

  ];


  loadCurrentLocationData(){
    // current location function
    getUserCurrentLocation().then((value) async {

      print('current location');
      print(value.latitude.toString() + ' ' + value.longitude.toString());


      // add the current location as marker in google map
      _markers.add(

        Marker(
            markerId: MarkerId('2'),
            position: LatLng(value.latitude, value.longitude),
            infoWindow: const InfoWindow(
                title: 'current Location'
            )
        ),

      );

      // changing the camera position
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 14,
      );

      // integrate the new camera position to google maps
      final GoogleMapController controller = await  _controller.future;

      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      // set state for  new camera position
      setState(() {

      });

    });
  }



  // get current location function
  Future<Position> getUserCurrentLocation () async {

    await Geolocator.requestPermission().then((value) {

    }).onError((error, stackTrace) {
      print('error:' + error.toString());
    });

    // return position
    return await Geolocator.getCurrentPosition();

  }


  // get current location initially
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // call the currentLocation load function
    loadCurrentLocationData();

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('current location screen'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),

      body: GoogleMap(

        mapType: MapType.normal,
        markers: Set<Marker>.of(_markers),
        initialCameraPosition: _kGooglePlex,

        // camera position controller
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
      },

      ),


      // button for current location
      floatingActionButton: FloatingActionButton(

        onPressed: (){

          // current location function
          getUserCurrentLocation().then((value) async {

            print('current location');
            print(value.latitude.toString() + ' ' + value.longitude.toString());


            // add the current location as marker in google map
            _markers.add(

              Marker(
                  markerId: MarkerId('2'),
                  position: LatLng(value.latitude, value.longitude),
                  infoWindow: const InfoWindow(
                    title: 'current Location'
                  )
              ),

            );

            // changing the camera position
            CameraPosition cameraPosition = CameraPosition(
                target: LatLng(value.latitude, value.longitude),
                zoom: 14,
            );

            // integrate the new camera position to google maps
            final GoogleMapController controller = await  _controller.future;

            controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            // set state for  new camera position
            setState(() {

            });

          });


        },
        child: Icon(Icons.add),
      ),

    );
  }
}


