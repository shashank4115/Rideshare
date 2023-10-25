import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ridesharev2/Services/location/location_service.dart';
import 'package:location/location.dart' as loc;
import 'package:google_maps/google_maps.dart';

class MapPage extends StatefulWidget {
  final String reveiverUserEmail;
  final String receiverId;
  const MapPage(
      {super.key, required this.receiverId, required this.reveiverUserEmail});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSub;
  final LocationService _locationService = LocationService();
  _getLocation() async {
    try {
      final loc.LocationData _locationResult = await location.getLocation();
      _locationService.sendLocation(
          widget.receiverId,
          _locationResult.latitude!.toDouble(),
          _locationResult.longitude!.toDouble());
    } catch (e) {
      print(e);
    }
  }

  Future<void> _listenLocation() async {
    _locationSub = location.onLocationChanged.handleError((onError) {
      print(onError);
      _locationSub?.cancel();
      setState(() {
        _locationSub = null;
      });
    }).listen((loc.LocationData currentLocation) async {
      _locationService.sendLocation(
          widget.receiverId,
          currentLocation.latitude!.toDouble(),
          currentLocation.longitude!.toDouble());
    });
  }

  _stopListening() {
    _locationSub?.cancel();
    setState(() {
      _locationSub = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.reveiverUserEmail),
      ),
    );
  }
}
