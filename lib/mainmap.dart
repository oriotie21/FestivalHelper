import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../flutter_flow/my_markers.dart';

class MainMap extends StatefulWidget {
  @override
  _MainMapState createState() => _MainMapState();
}

class _MainMapState extends State<MainMap> {
  late GoogleMapController mapController;
  Set<MyMarker> markersList = new Set();

  List<Map<String, dynamic>> locations = [
    {
      "Location_Number": "1",
      "Location_Name": "Daeyang AI Center",
      "coordinates": [127.075698, 37.551114]
    },
    {
      "Location_Number": "2",
      "Location_Name": "Daeyang Hall",
      "coordinates": [127.074525, 37.548589]
    },
    {
      "Location_Number": "3",
      "Location_Name": "GwangGaeToe",
      "coordinates": [127.073275, 37.550224]
    },
    {
      "Location_Number": "4",
      "Location_Name": "PlayGround",
      "coordinates": [127.075151, 37.550381]
    },
    {
      "Location_Number": "5",
      "Location_Name": "Library",
      "coordinates": [127.074213, 37.551529]
    },
  ];

//
// add the markers to the markersList
  void _addMarkers() {
    locations.forEach((Map<String, dynamic> location) {
      final MyMarker marker = MyMarker(location['Location_Name'],
          id: MarkerId(location['Location_Number']),
          lat: location['coordinates'][1],
          lng: location['coordinates'][0],
          onTap: null);

      markersList.add(marker);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        initialCameraPosition:
        CameraPosition(target: LatLng(37.550608 , 127.074272), zoom: 17.5),
        onMapCreated: _onMapCreated,
        myLocationEnabled: true,
        mapType: MapType.normal,
        markers: markersList.toSet());
  }

  void _onMapCreated(GoogleMapController controller) {
    // update map controller
    setState(() {
      mapController = controller;
    });
    // add the markers to the map
    _addMarkers();

    // create bounding box for view
    LatLngBounds _bounds = FindBoundsCoordinates().getBounds(markersList);

    // adjust camera to boundingBox
    controller.animateCamera(CameraUpdate.newLatLngBounds(_bounds, 100.0));
  }
}

///
/// used to calculate the boundry for rendering the markers
///
class FindBoundsCoordinates {
  LatLngBounds getBounds(Set<MyMarker> locations) {
    List<double> latitudes = [];
    List<double> londitude = [];

    locations.toList().forEach((index) {
      latitudes.add(index.position.latitude);
      londitude.add(index.position.longitude);
    });

    return LatLngBounds(
      southwest: LatLng(latitudes.reduce(min), londitude.reduce(min)),
      northeast: LatLng(latitudes.reduce(max), londitude.reduce(max)),
    );
  }
}