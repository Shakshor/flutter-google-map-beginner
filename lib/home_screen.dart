import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreenState extends StatefulWidget {
  const HomeScreenState({super.key});

  @override
  State<HomeScreenState> createState() => _HomeScreenStateState();
}

class _HomeScreenStateState extends State<HomeScreenState> {

  // controller creating
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();



  // initial camera position
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(23.77549, 90.364763),
    zoom: 14,
  );

  // multiple markers set on map
  final List<Marker> _marker = [];

  final List<Marker> _list = const [

    // my current location
    Marker(
     markerId: MarkerId('1'),
     position: LatLng(23.77549, 90.364763),
      infoWindow: InfoWindow(
        title: 'My Position'
      )
    ),

    // second location -2
    Marker(
        markerId: MarkerId('2'),
        position: LatLng(23.79549, 90.364763),
        infoWindow: InfoWindow(
            title: 'My 2nd Position'
        )
    ),

    // second location -2
    Marker(
        markerId: MarkerId('3'),
        position: LatLng(23.78549, 90.364763),
        infoWindow: InfoWindow(
            title: 'My 3rd Position'
        )
    ),



    // tokyo, japan
    Marker(
        markerId: MarkerId('4'),
        position: LatLng(35.652832, 139.839478),
        infoWindow: InfoWindow(
          title: 'Tokyo, Japan'
        )
    )

  ];





 // initially add the position or marker on google map
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // add list of the marker
    _marker.addAll(_list);

  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        // google map integration
        body: GoogleMap(

          initialCameraPosition: _kGooglePlex,
          mapType: MapType.normal,

          // marker set on map
          markers: Set<Marker>.of(_marker),

          onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
          },

        ),


        // floating action button
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.location_city_outlined),
          onPressed: () async {

          },
        ),

      ),
    );
  }
}
