// import 'dart:convert';

// // import 'package:http/http.dart' as http;
// import 'package:dio/dio.dart';

// const GOOGLE_API_KEY = 'AIzaSyAWYSyBXnIpC6f8B-EJ-UCeYKyCzlWXX_8';

// class LocationHelper {
//   static String genrateLocationPreviewImage(
//       {double latitude, double longitude}) {
//     return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
//   }

//   static Future<String> getPlaceAddress(double lat, double lng) async {
// final url=
//         'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY';
//         // 'https://maps.googleapis.com/maps/api/geocode/json?latlng=40.714224,-73.961452&key=$GOOGLE_API_KEY';
//     // final response = await http.get(Uri.http('https://maps.googleapis.com','/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY'),);
//     // final response = await http.get(url);
//         // final  response = await http.get(
//         // 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY');
//     // return json.decode(response.body)['results'][0]['formatted_address'];
//  var dio = Dio();
//   final response = await dio.get(url);
//   print(response.data);
//   return json.decode(response.data)['results'][0]['formatted_address'];
   
//   }
// }
