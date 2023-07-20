import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class PolygoneScreen extends StatefulWidget {
  const PolygoneScreen({super.key});

  @override
  State<PolygoneScreen> createState() => _PolygoneScreenState();
}

class _PolygoneScreenState extends State<PolygoneScreen> {

  // initial_google_map
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  // initial_camera_position
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(23.766149309382033, 90.35843960508048),
    zoom: 14.4746,
  );



  // polygone set
  Set<Polygon> _polygone = HashSet <Polygon>();


  List <LatLng> points = [

    LatLng(23.766149309382033, 90.35843960508048),
    LatLng(23.768663, 90.345994),
    LatLng(23.757290727026554, 90.36119934471157),
    LatLng(23.766149309382033, 90.35843960508048),

  ];


  // load the latlang
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    _polygone.add(
      Polygon(
          polygonId: PolygonId('1'),
          points: points,
          fillColor: Colors.lightBlueAccent.withOpacity(0.3),
          geodesic: true,
          strokeColor: Colors.blue,
          strokeWidth: 2
      )
    );

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Polygone'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),

      body: GoogleMap(

        // initial_camera_position
        initialCameraPosition: _kGooglePlex,
        mapType: MapType.normal,
        polygons: _polygone,
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },

      ),

    );
  }
}
