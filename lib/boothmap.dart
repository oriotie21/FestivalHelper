import 'package:enterancemanager/mainmap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'flutter_flow/my_markers.dart';

class BoothMapWidget extends StatefulWidget {
  const BoothMapWidget({
    Key? key,
  }) : super(key: key);

  @override
  _BoothMapWidget createState() => _BoothMapWidget();
}

class _BoothMapWidget extends State<BoothMapWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  //부스 관련 변수
  String selectedBoothName = "부스를 선택해 주세요";

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
  void _addMarkers() {
    locations.forEach((Map<String, dynamic> location) {
      final MyMarker marker = MyMarker(location['Location_Name'],
          id: MarkerId(location['Location_Number']),
          lat: location['coordinates'][1],
          lng: location['coordinates'][0],
          onTap : () => {setState((){selectedBoothName=location['Location_Name'];})} );
      markersList.add(marker);
    });
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

  @override
  Widget build(BuildContext context) {
    // Customize what your widget looks like when it's loading.
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).tertiaryColor,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        automaticallyImplyLeading: false,
        /*leading: InkWell(
              onTap: () async {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_rounded,
                color: FlutterFlowTheme.of(context).secondaryText,
                size: 24,
              ),
            ),*/
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(37.550608, 127.074272), zoom: 17.5),
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              mapType: MapType.normal,
              markers: markersList.toSet()
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            color: Color(0x230E151B),
                            offset: Offset(0, 2),
                          )
                        ],
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 16, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '$selectedBoothName',
                                        textAlign: TextAlign.center,
                                        style:
                                            FlutterFlowTheme.of(context).title1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 16, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '부스 소개',
                                        style:
                                            FlutterFlowTheme.of(context).title2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 16, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      // Customize what your widget looks like when it's loading.
                                      child: Text(
                                        '[Booth 1 line introduction]',
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context)
                                            .subtitle1
                                            ?.override(
                                              fontFamily: 'Outfit',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 16, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '최근 방문 인원',
                                        style:
                                            FlutterFlowTheme.of(context).title2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 16, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        // Customize what your widget looks like when it's loading.
                                        child: Text(
                                      '[Booth 1 line introduction]',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .subtitle1
                                          ?.override(
                                            fontFamily: 'Outfit',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                          ),
                                    )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
