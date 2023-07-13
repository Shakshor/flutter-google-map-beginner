import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';


class ConvertLatLangToAddress extends StatefulWidget {
  const ConvertLatLangToAddress({super.key});

  @override
  State<ConvertLatLangToAddress> createState() => _ConvertLatLangToAddressState();
}

class _ConvertLatLangToAddressState extends State<ConvertLatLangToAddress> {

  // state
  String stAddress = '', stLatLang = '';



  @override
  Widget build(BuildContext context) {
    return Scaffold(

    // app bar
      appBar: AppBar(
      title: const Text('Google Map'),
      centerTitle: true,
      backgroundColor: Colors.blue,
    ),


      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [


          Text(stAddress),

          Text(stLatLang),

          // onTap function
          GestureDetector(

            onTap: () async {

              // location address
              List<Location> locations = await locationFromAddress("Gronausestraat 710, Enschede");

              // latitude, longitude
              List<Placemark> placemarks = await placemarkFromCoordinates(52.2165157, 6.9437819);

              // set the state
              setState(() {

                // convert to address
                stAddress = placemarks.reversed.last.locality.toString() + ',  ' + placemarks.reversed.last.country.toString();

                // convert to latitude & longitude
                stLatLang = '${locations.last.latitude.toString()} ${locations.last.longitude.toString()}';


              });
              
            },

            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(

                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.blue
                ),

                child: const Center(child: Text('Convert')),
              ),
            ),

          ),


        ],

      ),

    );
  }
}
