
import 'package:flutter/material.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';
import 'package:meet_network_image/meet_network_image.dart';



class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  @override
  Widget build(BuildContext context) {
    final controller = MapController(
      location: LatLng(46.13, 12.21),
    );

    void _gotoDefault() {
      controller.center = LatLng(46.13, 12.21);
    }

    void _onDoubleTap() {
      controller.zoom += 0.5;
    }

    Offset _dragStart;
    double _scaleStart = 1.0;
    void _onScaleStart(ScaleStartDetails details) {
      _dragStart = details.focalPoint;
      _scaleStart = 1.0;
    }

    void _onScaleUpdate(ScaleUpdateDetails details) {
      final scaleDiff = details.scale - _scaleStart;
      _scaleStart = details.scale;

      if (scaleDiff > 0) {
        controller.zoom += 0.02;
      } else if (scaleDiff < 0) {
        controller.zoom -= 0.02;
      } else {
        final now = details.focalPoint;
        final diff = now - _dragStart;
        _dragStart = now;
        controller.drag(diff.dx, diff.dy);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Map Demo'),
      ),
      body: GestureDetector(
        onDoubleTap: _onDoubleTap,
        onScaleStart: _onScaleStart,
        onScaleUpdate: _onScaleUpdate,
        onScaleEnd: (details) {
          print(
              "Location: ${controller.center.latitude}, ${controller.center.longitude}");
        },
        child: Stack(
          children: [
            Map(
              controller: controller,
              builder: (context, x, y, z) {
                final url =
                    'https://www.google.com/maps/vt/pb=!1m4!1m3!1i$z!2i$x!3i$y!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425';

                return Image.network(url);


              },
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _gotoDefault,
        tooltip: 'My Location',
        child: Icon(Icons.my_location),
      ),
    );
  }
}

/*Container(
                        child: IconButton(
                          icon: Icon(Icons.maps_ugc_outlined),
                          color: Colors.blueAccent,
                          iconSize: 40,
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
                      ),*/
