import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:places_app/models/place.dart';
import 'package:flutter_map/flutter_map.dart';

class MapScreen extends StatefulWidget {

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  var locdata;

  void _getCurrentLocation() async {
     Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      locdata = LatLng(position.latitude,position.longitude);
    });
  }

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Map'),
        actions: [
            IconButton(
              icon: Icon(Icons.check),
              onPressed: locdata == null
                  ? null
                  : () {
                      Navigator.of(context).pop(locdata);
                    },
            ),
        ],
      ),
      body: 
      // GoogleMap(
      //   initialCameraPosition: CameraPosition(
      //     target: LatLng(
      //       widget.initialLocation.latitude,
      //       widget.initialLocation.longitude,
      //     ),
      //     zoom: 16,
      //   ),
      //   onTap: widget.isSelecting ? _selectLocation : null,
      //   markers: (_pickedLocation == null && widget.isSelecting)
      //       ? null
      //       : {
      //           Marker(
      //             markerId: MarkerId('m1'),
      //             position: _pickedLocation ??
      //                 LatLng(
      //                   widget.initialLocation.latitude,
      //                   widget.initialLocation.longitude,
      //                 ),
      //           ),
      //         },
      // ),
       FlutterMap(
        options: MapOptions(
          onTap: (data) {
            setState(() {
              locdata = data;
            });
          },
          center: locdata,
          zoom: 13.0,
        ),
        children: <Widget>[
          TileLayerWidget(
              options: TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'])),
          MarkerLayerWidget(
              options: MarkerLayerOptions(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: locdata,
                builder: (ctx) =>
                    Icon(Icons.location_on, color: Colors.redAccent),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
