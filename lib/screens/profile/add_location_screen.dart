// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:techconnect_frontend/models/location_dto.dart';
import 'package:techconnect_frontend/screens/home_screen.dart';
import 'package:techconnect_frontend/services/notification_service.dart';
import 'package:techconnect_frontend/services/user_profile_servide.dart';
import 'package:techconnect_frontend/utils/custom_page_route.dart';

class AddLocationScreen extends StatefulWidget {
  const AddLocationScreen({super.key});

  @override
  State<AddLocationScreen> createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  
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
    // print('longitud del set')
    var flag = _markers.length == 0 ? true : false;
    print('VALOR DE FLAG $flag');
    _markers.add(
      Marker(
        markerId: MarkerId(position.toString()),
        position: position,
        icon: icon,
        infoWindow: InfoWindow(title: DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.now())),
        onTap: () => _removeLocation(position),
      )
    );
    moveCamera(position);
    if (flag) {
      _saveUserLocation();
    }
    setState(() {});
  }

  void _removeLocation(LatLng position) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: const Icon(Icons.delete, color: Colors.red, size: 50),
          title: const Center(child: Text('Eliminar ubicacion')),
          content: const Text('Esta seguro de que desea eliminar esta ubicacion?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), 
              child: const Text('Cancelar'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.lightBlue
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.lightBlue
              ),
              child: const Text('Eliminar'),
              onPressed: () {
                setState(() {
                  _markers.removeWhere((element) => element.position == position);
                });
                Navigator.of(context).pop();
                // If the size of _markers set is equal to 1 call the function to save location
                if (_markers.length == 1) {
                  _saveUserLocation();
                }
              },
            )
          ],
        );
      },
    );
  }

  Future<void> moveCamera(LatLng position) async {
    // final controller = await googleMapController.future;
    _controller?.animateCamera(CameraUpdate.newLatLng(position));
  }

  Future<void> _saveUserLocation() async {
    var position = _markers.first.position;
    bool isLoading = false;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          icon: const Icon(Icons.question_answer, color: Colors.lightBlue, size: 50,),
          title: const Center(child: Text('Guardar ubicacion')),
          content: isLoading
            ? const Center(child: CircularProgressIndicator())
            : const Text('Desea guardar esta ubicacion para su perfil?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), 
              child: const Text('Cancelar'), 
              style: TextButton.styleFrom(
                foregroundColor: Colors.lightBlue
              )
            ),

            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.lightBlue
              ),
              child: const Text('Guardar'),
              onPressed: isLoading 
              ? null  // Disabled button while the location is saving
              : () async {
                // Navigator.pop(context, 'add-location');
                // setState(() {
                //   isLoading = true;
                // });
                await Future.delayed(const Duration(milliseconds: 3000));

                final userProfileService = Provider.of<UserProfileService>(context, listen: false);
                LocationDto? locationDto = await userProfileService.saveUserLocation(context, position);
                if (locationDto != null) {
                  // setState(() {
                  //   isLoading = false;
                  // });
                  Navigator.of(context).push(CustomPageRouter(child: const HomeScreen()));
                  await Future.delayed(const Duration(milliseconds: 700));
                  NotificationService.showInfoDialogAlert(
                    context,
                    'Bienvenido',
                    'Hola ${locationDto.userProfileDTO.firstName}, ahora puedes usar la aplicacion',
                    null
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Selecciona tu ubicacion')),
        automaticallyImplyLeading: false,
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
              onLongPress: (LatLng position) => _removeLocation(position),
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

