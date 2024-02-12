import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class AddLocationScreen extends StatefulWidget {
  const AddLocationScreen({super.key});

  @override
  State<AddLocationScreen> createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  
  static const LatLng _center = const LatLng(37.4234, -122.6848);
  GoogleMapController? _controller;
  MapType _currentMapType = MapType.normal;
  Set<Marker> _markers = {};
  CameraPosition initialCameraPosition = const CameraPosition(
    zoom: 11,
    target: LatLng(37.4234, -122.6848),
  );
  BitmapDescriptor icon = BitmapDescriptor.defaultMarker;

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

  void _addLocation(LatLng position) {
    print(position);
    _markers.add(
      Marker(
        markerId: MarkerId(position.toString()),
        position: position,
        icon: icon,
        infoWindow: InfoWindow(title: DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.now())),
      )
    );
    moveCamera(position);
    setState(() {});
  }

  Future<void> moveCamera(LatLng position) async {
    // final controller = await googleMapController.future;
    _controller?.animateCamera(CameraUpdate.newLatLng(position));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Selecciona tu ubicacion')),
        backgroundColor: Colors.lightBlue,
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: initialCameraPosition,
              mapType: _currentMapType,
              markers: _markers,
              onTap: (LatLng position) {
                _addLocation(position);
              },
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
        ),
      )
    );
  }
}

