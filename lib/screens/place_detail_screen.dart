import 'package:flutter/material.dart';
import 'package:places_app/screens/map_screen.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';
import 'package:places_app/providers/user_places.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = 'place-Detail';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectedPlace =
        Provider.of<UserPlaces>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(height: 10),
          Text(
            selectedPlace.location.address,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 10),
          Container(
           height: 300,
           width: 300,
           child: FlutterMap(
            options: MapOptions(
              center: LatLng(selectedPlace.location.latitude, selectedPlace.location.longitude),
              zoom: 13.0,
            ),
            layers: [
              MarkerLayerOptions(
                markers: [
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: LatLng(selectedPlace.location.latitude, selectedPlace.location.longitude),
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
        ],
      ),
    );
  }
}
