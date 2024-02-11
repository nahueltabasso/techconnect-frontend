import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddLocationScreen extends StatefulWidget {
  const AddLocationScreen({super.key});

  @override
  State<AddLocationScreen> createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  
  static const LatLng _center = const LatLng(37.4234, -122.6848);
  MapType _currentMapType = MapType.normal;
  final Set<Marker> _markers = {};
  GoogleMapController? _controller;


  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _onMapTypeChange() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal ? MapType.satellite : MapType.normal;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Selecciona tu ubicacion')),
        backgroundColor: Colors.lightBlue,
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(target: _center, zoom: 10),
            mapType: _currentMapType,
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: FloatingActionButton(
                materialTapTargetSize: MaterialTapTargetSize.padded,
                backgroundColor: Colors.lightBlue,
                child: const Icon(Icons.map, size: 30.0),
                onPressed: () => _onMapTypeChange(),
              ),
            ),
          ),

          const SizedBox(height: 10,),
        ]
      )
    );
  }
}