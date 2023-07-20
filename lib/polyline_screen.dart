import 'package:flutter/material.dart';


class PolyLineScreen extends StatefulWidget {
  const PolyLineScreen({super.key});

  @override
  State<PolyLineScreen> createState() => _PolyLineScreenState();
}

class _PolyLineScreenState extends State<PolyLineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('PolyLine'),
      ),


    );
  }
}
