import 'dart:async';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerInfoWindow extends StatefulWidget {
  const CustomMarkerInfoWindow({super.key});

  @override
  State<CustomMarkerInfoWindow> createState() => _CustomMarkerInfoWindowState();
}

class _CustomMarkerInfoWindowState extends State<CustomMarkerInfoWindow> {

  // google_map_initialize
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  // controller initialize for  custom_info_window
  CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();

  // states
  final List<Marker> _markers = <Marker>[];
  final List<LatLng> _latLang = [
    LatLng(23.775492, 90.364759), LatLng(23.786492, 90.364766), LatLng(23.7777492, 90.370009),
    LatLng(23.786492, 90.37100), LatLng(23.78100, 90.372759), LatLng(23.78200, 90.374759)
  ];


  // for loading the marker on map
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // loading marker data function calling
    loadMarkerData();

  }



  // loading marker data function
  loadMarkerData(){


    // add marker to the list _markers
    for(int i = 0; i < _latLang.length; i++){

      if(i % 2 == 0) {

        _markers.add(
            Marker(
                markerId: MarkerId(i.toString()),
                position: _latLang[i],
                icon: BitmapDescriptor.defaultMarker,
                // onTap function
                onTap:(){

                  _customInfoWindowController.addInfoWindow!(

                    // widget
                    Container(
                      width: 200,
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Colors.grey
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),

                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.blue,
                      ),

                    ),

                    // latlang
                    _latLang[i],
                  );

                }

            )
        );

      }else{
        _markers.add(
            Marker(
                markerId: MarkerId(i.toString()),
                position: _latLang[i],
                icon: BitmapDescriptor.defaultMarker,
                // onTap function
                onTap:(){

                  _customInfoWindowController.addInfoWindow!(

                    // widget
                    Container(
                      width: 200,
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Colors.grey
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          // image container
                          Container(
                            width: 300,
                            height: 120,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage('https://img.freepik.com/free-photo/fresh-pasta-with-hearty-bolognese-parmesan-cheese-generated-by-ai_188544-9469.jpg?w=1060&t=st=1689661693~exp=1689662293~hmac=0bb7fd59fd6ebd4b1ecbd75a547bc1ebc3ff9ea558605d400cc60bcd7b3ad60b'),
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.fitWidth,
                              ),
                              borderRadius:BorderRadius.all(
                                  Radius.circular(10.0)
                              ),
                              color: Colors.black,
                            ),
                          ),

                          // row container
                          const Padding(
                            padding:  EdgeInsets.only(
                                top: 4,right: 10, left: 10
                            ),
                            child: Row(

                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [
                                Text('Noodles'),

                                Spacer(),

                                Text('300tk'),

                              ],
                            ),
                          ),



                          // details info
                          const Padding(
                            padding:  EdgeInsets.only(top: 4,right: 10, left: 10),
                            child: Text('noodle, a cooked egg-and-flour paste prominent in European and Asian cuisine,'),
                          ),

                        ],

                      ),

                    ),

                    // latlang
                    _latLang[i],
                  );

                }

            )
        );
      }



      // set the state
      setState(() {

      });
    }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Custom Info Window Screen'),
        backgroundColor: Colors.blue,
      ),


      body: Stack(
        children: [

          // google_map
          GoogleMap(

            // initial camera position set
              initialCameraPosition: CameraPosition(
                target: LatLng(23.775492, 90.364759),
                zoom: 14,
              ),
            markers: Set<Marker>.of(_markers),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,

            // onPressed function
            onTap: (position){
              _customInfoWindowController.hideInfoWindow!();
            },

            // for camera move
            onCameraMove: (position){
                _customInfoWindowController.onCameraMove!();
            },

            onMapCreated: (GoogleMapController controller){
                _customInfoWindowController.googleMapController = controller;
            },

          ),


          // custom_info_window design
          CustomInfoWindow(
              controller: _customInfoWindowController,
              height: 200,
              width: 300,
              offset: 35,
          )


        ],
      ),


    );
  }
}
