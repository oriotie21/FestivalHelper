import 'dart:convert';

import 'package:enterancemanager/UserManager.dart';
import 'package:enterancemanager/httprequest.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'myqrcode.dart';

class StampBoardWidget extends StatefulWidget {
  const StampBoardWidget({Key? key}) : super(key: key);

  @override
  _StampBoardWidgetState createState() => _StampBoardWidgetState();
}

class _StampBoardWidgetState extends State<StampBoardWidget>
    with TickerProviderStateMixin {
  /*final animationsMap = {
    'containerOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(0, 70),
          end: Offset(0, 0),
        ),
      ],
    ),
  };*/
  /*PagingController<DocumentSnapshot?, ToDoListRecord>? _pagingController;
  Query? _pagingQuery;
  List<StreamSubscription?> _streamSubscriptions = [];
*/
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<Map> completedStamps = <Map>[];
  List<Map> waitingStamps = <Map>[];
  List stampList = [];

  @override
  void initState() {
    super.initState();
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      /*await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShowQRWidget(),
        ),
      );*/
    });
/*
    setupAnimations(
      animationsMap.values.where((anim) =>
      anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );*/
  }

  @override
  void dispose() {
    //_streamSubscriptions.forEach((s) => s?.cancel());
    super.dispose();
  }

  Future<void> loadStamps() async {
    HttpRequest request = HttpRequest();
    UserCredential credential = UserCredential();
    String? username = await credential.getUsername();
    http.Response r = await request.sendGetRequest("/api/visits/user/"+username!, null);
    stampList = jsonDecode(r.body); //json list

/*
    Map<String, dynamic> resp = jsonDecode(r.body);
    //List<Map<String, dynamic>> stampList =
        new List<Map<String, dynamic>>.from(resp["response"]);
    stampList.forEach((element) {
      if (element["end_time"] == null) {
        waitingStamps.add(element);
      } else {
        completedStamps.add(element);
      }
      Logger().v(waitingStamps.length);
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShowQRWidget(),
            ),
          );
        },
        backgroundColor: Color(0xFFC30E2E),
        elevation: 8,
        child: Icon(
          Icons.qr_code_scanner_rounded,
          color: FlutterFlowTheme.of(context).white,
          size: 32,
        ),
      ),
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).tertiaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          'Stamp Board',
          style: FlutterFlowTheme.of(context).title2?.override(
                fontFamily: 'Outfit',
                color: Colors.white,
                fontSize: 22,
              ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 2,
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: loadStamps(),
            builder: (buildContext, asyncSnapshot) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                    child: Text(
                      '지금까지 방문한 장소입니다!',
                      textAlign: TextAlign.start,
                      style: FlutterFlowTheme.of(context).title2?.override(
                            fontFamily: 'Outfit',
                            color: FlutterFlowTheme.of(context).primaryText,
                          ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        // Customize what your widget looks like when it's loading the first page.
                        itemCount: stampList.length,
                        itemBuilder: (context, listViewIndex) {
                          //final listViewToDoListRecord =
                          //_pagingController!.itemList![listViewIndex];
                         /* Map<String, dynamic> visit =
                              Map<String, dynamic>.from(
                                  completedStamps.elementAt(listViewIndex));

                          */
                          var stamp = stampList.elementAt(listViewIndex);
                          return Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                            child: InkWell(
                              onTap: () async {
                                /*
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ViewBoothInfoWidget(
                                      toDoNote: listViewToDoListRecord
                                          .reference,
                                    ),
                              ),
                            );
                            */
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 5,
                                      color: Color(0x230E151B),
                                      offset: Offset(0, 2),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16, 12, 0, 12),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              stamp["booth_id"].toString()!,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .title2,
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 4, 0, 0),
                                                  child: Text(
                                                    DateFormat("yyyy-MM-dd HH:MM:ss").format(DateTime.parse(stamp["start_time"])),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .subtitle2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 20, 0),
                                          child: /*FaIcon(
                                        icon : Icon( )
                                        FontAwesomeIcons.circle,
                                        color: Color(0xFFC30E2E),
                                        size: 50,
                                      )*/
                                              Icon(
                                            Icons.check_circle_outlined,
                                            color: Color(0xFF65FF00),
                                            size: 50,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ) /*.animateOnPageLoad(
                            animationsMap['containerOnPageLoadAnimation']!)*/
                            ,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
