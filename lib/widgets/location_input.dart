import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:places_app/helpers/location_helper.dart';
import 'package:places_app/screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function onselectPlace;
  LocationInput(this.onselectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
 var locData;

  Future<void> _getCurrentLocation() async {
    try{
          Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        locData = position;
      });
      widget.onselectPlace(locData.latitude, locData.longitude);
    }catch(error){
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
          
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    setState(() {
      locData = selectedLocation;
    });
    widget.onselectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          height: 170,
          width: double.infinity,
          child: locData == null
              ? Text(
                  'No Location Chosen',
                  textAlign: TextAlign.center,
                )
              :FlutterMap(
                  options: MapOptions(
                    center: LatLng(locData.latitude, locData.longitude),
                    zoom: 13.0,
                  ),
                  layers: [
                    MarkerLayerOptions(
                      markers: [
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: LatLng(locData.latitude, locData.longitude),
                          builder: (ctx) =>
                              Icon(Icons.location_on, color: Colors.redAccent),
                        ),
                      ],
                    ),
                  ],
                  children: <Widget>[
                    TileLayerWidget(
                        options: TileLayerOptions(
                            urlTemplate:
                                "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                            subdomains: ['a', 'b', 'c'])),
                  ],
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              icon: Icon(Icons.location_on),
              label: Text(
                'Current Location',
              ),
            ),
            TextButton.icon(
              onPressed: _selectOnMap,
              icon: Icon(Icons.map),
              label: Text(
                'Select On Map',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
