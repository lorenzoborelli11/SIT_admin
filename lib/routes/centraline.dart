import 'dart:async';
import 'dart:math' as math show pi;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore_web/cloud_firestore_web.dart';
import 'package:latlng/latlng.dart';

import "package:latlong/latlong.dart" as LatLng;
import 'package:latlong/latlong.dart';
import 'package:map_controller/map_controller.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:sit_lb_2021/routes/drawer.dart';
import 'package:sit_lb_2021/routes/map.dart';
import 'package:sit_lb_2021/utils/dragmarker.dart';

class Centraline extends StatefulWidget {
  @override
  _CentralineState createState() => _CentralineState();
}

class _CentralineState extends State<Centraline> {

  List<Marker> marker = <Marker>[];
  final _advancedDrawerController = AdvancedDrawerController();
  MapController mapController;
  StatefulMapController statefulMapController;
  StreamSubscription<StatefulMapControllerStateChange> sub;
  TextEditingController tiposegnalazione = TextEditingController();
  TextEditingController descrizione = TextEditingController();
  int selectedValue;
  String buttonText = "Sversamento di liquidi in acqua";


  void loadData() async {
    print("Loading geojson data");
    final data = await rootBundle.loadString('idrografia-belluno-stazioni-laghi-bio1.json');
    await statefulMapController.fromGeoJson(data,
        markerIcon: Icon(Icons.local_airport), verbose: true);
  }


  @override
  void initState() {

    getMarkers();

    mapController = MapController();
    statefulMapController = StatefulMapController(mapController: mapController);
    statefulMapController.onReady.then((_) => loadData());
    sub = statefulMapController.changeFeed.listen((change) => setState(() {}));
    super.initState();
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    final width = MediaQuery
        .of(context)
        .size
        .width;
    return AdvancedDrawer(
      backdropColor: Colors.blueGrey,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      childDecoration: const BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (context, value, child) {
                return Icon(
                  value.visible ? Icons.clear : Icons.menu,
                  color: Colors.red.shade900,
                );
              },
            ),
          ),
        ),

        body: Stack(
          children: [
            Container(
              color: Colors.white,
                child: Center(child: Image(image: AssetImage('assets/images/idr.JPG')))),
          ],


      ),
      ),
      drawer: MyDrawer(),
    );
  }





  List<Marker> getMarkers() {



    List<Marker> markerzz = <Marker>[];


    FirebaseFirestore.instance.collection("segnalazioni").get().then((docs) {
      if (docs.docs.isNotEmpty) {
        for (int i = 0; i < docs.docs.length; ++i) {
          markerzz.insert(i, Marker(
            width: 80.0,
            height: 80.0,
            point: LatLng.LatLng(
                double.parse(docs.docs[i].data()['coordlat'].toString()), double.parse(docs.docs[i].data()['coordlong'].toString())),
            builder: (ctx) =>
                Container(
                  child: IconButton(
                    icon: Icon(Icons.room_sharp),
                    color: Colors.red.shade900,
                    iconSize: 30,
                    onPressed: () {
                      final width = MediaQuery
                          .of(context)
                          .size
                          .width;
                      final height = MediaQuery
                          .of(context)
                          .size
                          .width;
                      Widget OkButton = FlatButton(
                        child: Text("Ok", style: TextStyle(
                          fontSize: 20,
                          color: Colors.red.shade900,
                          fontWeight: FontWeight.w800,
                          fontFamily: "Montserrat",
                        ),),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      );
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: height * 0.5,
                            width: width * 0.3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight:
                                  Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.8),
                                  spreadRadius: 5,
                                  blurRadius: 10,
                                  offset: Offset(0,
                                      3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: AlertDialog(
                              title: Text(
                                "Descrizione" ,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.red.shade900,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: "Montserrat",
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(20.0),
                              ),
                              elevation: 0,
                              backgroundColor: Color(0xFFEEEEEE),
                              content: Text(
                                "" +

                                    " \nData: " +
                                    getDate(docs.docs[i].data()['date']) +
                                    " \nTipo segnalazione: " +
                                    docs.docs[i].data()['type'] +
                                    "\nDescrizione: " +
                                    docs.docs[i].data()['descriz'] +
                                    " \nLatitudine: " +
                                    (docs.docs[i].data()['coordlat']).toString() +
                                    " \nLongitudine: " +
                                    (docs.docs[i].data()['coordlong']).toString(),
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Montserrat",
                                ),
                              ),
                              actions: [
                                OkButton,

                              ],
                            ),
                          );
                        },
                      );



                    },
                  ),),),);
        }

      }
    });
    return markerzz;
  }

}

