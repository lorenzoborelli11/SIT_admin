
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';

import "package:latlong/latlong.dart" as LatLng;
import 'package:map_controller/map_controller.dart';
import 'package:sit_lb_2021/utils/dragmarker.dart';



class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {

  MapController mapController;
  StatefulMapController statefulMapController;
  StreamSubscription<StatefulMapControllerStateChange> sub;

  @override
  void initState() {
    // intialize the controllers
    mapController = MapController();
    statefulMapController = StatefulMapController(mapController: mapController);

    // wait for the controller to be ready before using it
    statefulMapController.onReady.then((_) => print("The map controller is ready"));

    /// [Important] listen to the changefeed to rebuild the map on changes:
    /// this will rebuild the map when for example addMarker or any method
    /// that mutates the map assets is called
    sub = statefulMapController.changeFeed.listen((change) => setState(() {}));
    super.initState();
    }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Benvenuti in SIT Hydrography')),
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
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c']
              ),

              MarkerLayerOptions(

                markers: [

                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: LatLng.LatLng(46.1503, 12.2171),
                    builder: (ctx) =>
                        Container(
                            child: IconButton(
                              icon: Icon(Icons.room_sharp),
                              color: Colors.blueAccent,
                              iconSize: 30,
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (builder) {
                                      return Container(
                                        color: Colors.white,
                                        child: Center(child: Text("blblaaasdas")),);
                                    }
                                );
                              },
                            )
                        ),
                  ),


                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng.LatLng(46.26, 12.29),
                  builder: (ctx) =>
                      Container(
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
                                      child: Center(child: Text("blblaaasdas")),);
                                  }
                              );
                            },
                          )
                      ),
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
                    builder: (ctx) => Container( child: Icon(Icons.location_on, size: 50) ),
                    onDragStart:  (details,point) => print("Start point $point"),
                    onDragEnd:    (details,point) => print("End point $point"),
                    onDragUpdate: (details,point) {},
                    onTap:        (point) { print("on tap"); },
                    onLongPress:  (point) { print("on long press"); },
                    feedbackBuilder: (ctx) => Container( child: Icon(Icons.edit_location, size: 75) ),
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
          // Add your onPressed code here!
        },
        label: const Text('Segnala', style: TextStyle(color: Colors.black),),
        icon: const Icon(Icons.add_circle_rounded, color: Colors.black,),
        backgroundColor: Colors.redAccent,
      ),
    );



  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }
}

