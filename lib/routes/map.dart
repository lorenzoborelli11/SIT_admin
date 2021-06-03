import 'dart:async';
import 'dart:math' as math show pi;
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import "package:latlong/latlong.dart" as LatLng;
import 'package:map_controller/map_controller.dart';
import 'package:sit_lb_2021/routes/drawer.dart';
import 'package:sit_lb_2021/utils/dragmarker.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  MapController mapController;
  StatefulMapController statefulMapController;
  StreamSubscription<StatefulMapControllerStateChange> sub;

  TextEditingController tiposegnalazione = TextEditingController();
  TextEditingController descrizione = TextEditingController();

  @override
  void initState() {
    // intialize the controllers
    mapController = MapController();
    statefulMapController = StatefulMapController(mapController: mapController);

    // wait for the controller to be ready before using it
    statefulMapController.onReady
        .then((_) => print("The map controller is ready"));

    sub = statefulMapController.changeFeed.listen((change) => setState(() {}));

    // this is for CollapseSidebar

    super.initState();
  }

  final _advancedDrawerController = AdvancedDrawerController();

  Function postSegnalazione(
      LatLng, DateTime date, String tiposegnalaz, String descrizione,
      {String image}) {

  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final width = MediaQuery.of(context).size.width;
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
          title: Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: 'S',
                  style: GoogleFonts.portLligatSans(
                    textStyle: Theme.of(context).textTheme.display1,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.red.shade900,
                  ),
                  children: [
                    TextSpan(
                      text: 'IT',
                      style: TextStyle(color: Colors.black, fontSize: 30),
                    ),
                    TextSpan(
                      text: ' Hydrography',
                      style:
                          TextStyle(color: Colors.red.shade900, fontSize: 30),
                    ),
                  ]),
            ),
          ),
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
            FlutterMap(
              mapController: mapController,
              options: MapOptions(
                plugins: [
                  DragMarkerPlugin(),
                ],
                center: LatLng.LatLng(46.1503, 12.2171),
                zoom: 13.0,
              ),
              layers: [
                MarkerLayerOptions(markers: statefulMapController.markers),
                PolylineLayerOptions(polylines: statefulMapController.lines),
                PolygonLayerOptions(polygons: statefulMapController.polygons),
                TileLayerOptions(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c']),
                MarkerLayerOptions(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng.LatLng(46.1503, 12.2171),
                      builder: (ctx) => Container(
                          child: IconButton(
                        icon: Icon(Icons.room_sharp),
                        color: Colors.red.shade900,
                        iconSize: 30,
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (builder) {
                                return Container(
                                  color: Colors.white,
                                  child: Center(child: Text("blblaaasdas")),
                                );
                              });
                        },
                      )),
                    ),
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng.LatLng(46.26, 12.29),
                      builder: (ctx) => Container(
                          child: IconButton(
                        icon: Icon(Icons.report_rounded),
                        color: Colors.redAccent,
                        iconSize: 30,
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (builder) {
                                return Container(
                                  color: Colors.white,
                                  child: Center(child: Text("blblaaasdas")),
                                );
                              });
                        },
                      )),
                    ),
                  ],
                ),
                DragMarkerPluginOptions(
                  markers: [
                    DragMarker(
                      point: LatLng.LatLng(46.1503, 12.2171),
                      width: 80.0,
                      height: 80.0,
                      offset: Offset(0.0, -8.0),
                      builder: (ctx) =>
                          Container(child: Icon(Icons.location_on, size: 50)),
                      onDragStart: (details, point) =>
                          print("Start point $point"),
                      onDragEnd: (details, point) => print("End point $point"),
                      onDragUpdate: (details, point) {},
                      onTap: (point) {
                        print("on tap");
                      },
                      onLongPress: (point) {
                        showModalBottomSheet(
                            context: context,
                            builder: (builder) {
                              return SingleChildScrollView(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: width * 0.3, right: width * 0.3),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 15,
                                        ),
                                        _segnalaField("Tipo di segnalazione: ",
                                            tiposegnalazione),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        _segnalaField(
                                            "Descrizione: ", descrizione),
                                        SizedBox(
                                          height: 35,
                                        ),
                                    Container(
                                      child: Ink(
                                        decoration: BoxDecoration(
                                          color: Colors.red.shade900,
                                          borderRadius: BorderRadius.all(Radius.circular(40)),
                                        ),
                                        child: MaterialButton(
                                          onPressed: () {
                                            postSegnalazione(point, DateTime.now(), tiposegnalazione.text, descrizione.text);
                                            //print(point);
                                            //print(DateTime.now());
                                            //print( tiposegnalazione.text + descrizione.text);
                                            Fluttertoast.showToast(
                                            msg:
                                            "Grazie! La tua segnalazione è avvenuta con successo!",
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Color(0xFF424242),
                                            textColor: Colors.white,
                                            fontSize: 16.0);

                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 10,
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Segnala',
                                              style: TextStyle(fontSize: 20, color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      feedbackBuilder: (ctx) =>
                          Container(child: Icon(Icons.edit_location, size: 75)),
                      feedbackOffset: Offset(0.0, -18.0),
                      updateMapNearEdge: true,
                      nearEdgeRatio: 2.0,
                      nearEdgeSpeed: 1.0,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Fluttertoast.showToast(
                msg:
                    "Muovi il cursore nero nella posizione desiderata, successivamente tieni premuto lo stesso per 2 secondi.",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Color(0xFF424242),
                textColor: Colors.white,
                fontSize: 16.0);
          },
          label: const Text(
            'Segnala',
            style: TextStyle(color: Colors.white),
          ),
          icon: const Icon(
            Icons.add_circle_rounded,
            color: Colors.white,
          ),
          backgroundColor: Colors.red.shade900,
        ),
      ),
      drawer: MyDrawer(),
    );
  }

  Widget _segnalaField(String title, TextEditingController controller,
      {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
              controller: controller,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(12.0),
                    ),
                  ),
                  fillColor: Color(0xfff3f3f4),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide(
                        color: Colors.black,
                      )),
                  labelStyle: new TextStyle(
                    color: Colors.red.shade900,
                  ),
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitSegnala() {
    return Container(
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.red.shade900,
          borderRadius: BorderRadius.all(Radius.circular(40)),
        ),
        child: MaterialButton(
          onPressed: () {},
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 10,
            ),
            alignment: Alignment.center,
            child: Text(
              'Segnala',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}
