import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class CustomMarkerScreen extends StatefulWidget {
  const CustomMarkerScreen({super.key});

  @override
  State<CustomMarkerScreen> createState() => _CustomMarkerScreenState();
}

class _CustomMarkerScreenState extends State<CustomMarkerScreen> {


  // google map initialize
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();


  // states
  Uint8List? markerImage;




  // images list
  List<String> images = ['assets/icons/car.png','assets/icons/car2.png', 'assets/icons/marker.png',
  'assets/icons/marker2.png','assets/icons/marker3.png','assets/icons/motorbike.png'];

  // markers list
  final List<Marker> _markers = <Marker> [

    // first marker
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(23.775492, 90.364759),
    ),


  ];
  
  // latlang list
  final List<LatLng> _latlang = <LatLng> [
    LatLng(23.775492, 90.364759), LatLng(23.786492, 90.364766), LatLng(23.7777492, 90.370009),
    LatLng(23.786492, 90.37100), LatLng(23.78100, 90.372759), LatLng(23.78200, 90.374759)
  ];


  // initial camera position
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(23.775492, 90.364759),
    zoom: 14.4746,
  );



  // convert bytes from image file function
  Future<Uint8List> getBytesFromAssets (String path, int width) async {

    // load the path
    ByteData data = await rootBundle.load(path);

    // buffer the data and decode the image
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);

    // represent the info of decoded image
    ui.FrameInfo fi = await codec.getNextFrame();

    // convert the frame into byte data object & desired format
    // then convert the image into byte data as Uint8List
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // load marker function
    loadMarkerData();

  }


  // set the marker and load the markers
  loadMarkerData() async {


    for(int i = 0; i < images.length; i++){

      //  image to byte function calling
      final Uint8List markerIcon = await getBytesFromAssets(images[i], 50);

      _markers.add(
        Marker(
            markerId: MarkerId(i.toString()),
            position: _latlang[i],
            icon: BitmapDescriptor.fromBytes(markerIcon),
            infoWindow: InfoWindow(
              title: 'This is $i title',
            ),
        ),
      );

      setState(() {

      });

    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: GoogleMap(

          initialCameraPosition: _kGooglePlex,
          mapType: MapType.normal,
          markers: Set<Marker>.of(_markers),
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
          },

        ),
      ),

    );
  }
}


