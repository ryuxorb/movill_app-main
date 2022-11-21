import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart' as http;
import 'package:movill/src/app.dart';
import 'package:movill/src/polyline.dart';

import 'calendar.dart';
import 'constants.dart';
class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  Set<Marker> _markers = Set();
  // 초기 카메라 위치

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _markers.add(
      Marker(markerId: MarkerId('myInitialPosition'), position: LatLng(37.5233273,126.921252),infoWindow: InfoWindow(title: 'My Position', snippet: 'Where am I?')),
    );
  }

  static final LatLng companyLatLng = LatLng(
    37.5233273, //위도
    126.921252, //경도
  );
  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return position;
  }
  static final CameraPosition initialPosition = CameraPosition(
    target: companyLatLng,
    zoom: 15,
  );
  void _searchPlaces(
      String locationName,
      double latitude,
      double longitude,
      ) async{
        setState(() {
          _markers.clear();
        });
        final String url = '$baseUrl?key=$API_KEY&location=$latitude,$longitude&radius=1000&language=ko&keyword=$locationName';
        final response = await http.get(Uri.parse(url));

        if(response.statusCode ==200){
          final data = json.decode(response.body);

          if(data['status']=='OK'){
            GoogleMapController controller = await _controller.future;
            controller.animateCamera(
              CameraUpdate.newLatLng(
                LatLng(latitude,longitude),
              ),
            );

            setState(() {
              final foundPlaces = data['results'];

              for(int i=0; i <foundPlaces.length; i++){
                _markers.add(
                  Marker(
                      markerId: MarkerId(foundPlaces[i]['place_id']),
                      position: LatLng(
                        foundPlaces[i]['geometry']['location']['lat'],
                        foundPlaces[i]['geometry']['location']['lng'],
                      ),
                    infoWindow: InfoWindow(
                      title: foundPlaces[i]['name'],
                      snippet: foundPlaces[i]['vicinity'],
                    ),
                  ),
                );
              }
            });
          }
        }else{
          print('Fail to fetch place data');
        }
  }

  static final Polyline _polyLine =  Polyline(
      polylineId: PolylineId('polyline1'),
      points: [
        LatLng(37.5233273, 126.921252),
        LatLng(37.53, 126.921252)
      ],
      width: 5,
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: <Widget> [
          /*
          Container(
            child: Calendar(),
          ),*/
          Container(
            //padding: EdgeInsets.only(top: 70.0),
              child: GoogleMap(
                mapType: MapType.normal,
                polylines: {
                  _polyLine
                },
                initialCameraPosition: initialPosition, // 초기 카메라 위치
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                markers: _markers,
              ),
          ),
          Container(child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 25.0),
              child: MaterialButton(

                onPressed: () async {
                  //var gps = await getCurrentLocation();
                  _searchPlaces('베이커리', 37.5233273, 127.026437);
                },
                color: Colors.white,
                textColor: Colors.grey,
                child: Icon(
                  Icons.gps_fixed,
                  size: 24,
                ),
                padding: EdgeInsets.all(16),

                shape: CircleBorder(),
              ),
            ),
          ),)
        ],
      ),

    );
  }

}
