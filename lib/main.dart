import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_beginner/convert_latlang_to_address.dart';
import 'package:google_maps_beginner/custom_marker_info_window.dart';
import 'package:google_maps_beginner/custom_marker_screen.dart';
import 'package:google_maps_beginner/google_places_api_screen.dart';
import 'package:google_maps_beginner/home_screen.dart';
import 'package:google_maps_beginner/polygone_screen.dart';
import 'package:google_maps_beginner/user_current_location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,

        // primarySwatch: Colors.blue,

      ),
      home: const PolygoneScreen(),
    );
  }
}


