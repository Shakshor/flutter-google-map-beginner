import 'dart:convert';

import 'package:flutter/material.dart';

// for device id
import 'package:uuid/uuid.dart';
// http
import 'package:http/http.dart' as http;



class GooglePlacesApiScreen extends StatefulWidget {
  const GooglePlacesApiScreen({super.key});

  @override
  State<GooglePlacesApiScreen> createState() => _GooglePlacesApiScreenState();
}

class _GooglePlacesApiScreenState extends State<GooglePlacesApiScreen> {

  // place  field controller
  TextEditingController _placesController = TextEditingController();


  // device id
  var uuid = Uuid();
  // device token
  String _sessionToken = '1234';
  // place_list
  List<dynamic> _placeList = [];


  // add listener for search changes
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // controller called
    _placesController.addListener(() {

      // function call
      onChange();

    });
  }



  // input field changing function
  void onChange(){

    // session token checking
    if(_sessionToken == null ){

      // set token state
      // store the device id
      setState(() {
        _sessionToken = uuid.v4();
      });
    }

    // session token successful
    // get suggestion
    getSuggestion(_placesController.text);

  }


  //
  void getSuggestion(String input) async {

    // api_key
    String kPLACES_API_KEY = 'AIzaSyClVNTfcJ1EFHmCn_FEduteKE2aTFYueVE';
    String baseURL = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?';
    String request = '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';


    // http get response
    var response = await http.get(Uri.parse(request));

    var data = response.body.toString();

    print('data');
    print(data);


    // status code
    if(response.statusCode == 200){

      setState(() {
        _placeList = jsonDecode(response.body.toString())['predications'];
      });

    } else{
      throw Exception('Failed to load data');
    }


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        title: Text('Google Search Places Api'),
        backgroundColor: Colors.lightBlueAccent,
      ),


      // body form field
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(


          children: [


            // search places form field
            TextFormField(

              controller: _placesController,
              decoration: InputDecoration(
                hintText: 'Search Places With Name'
              ),


            )

          ],

        ),
      ),




    );
  }
}
