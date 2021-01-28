import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gomechanic/utils/LocationHandler.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MechanicMapScreen extends StatefulWidget {

  var lat,long;

  MechanicMapScreen(this.lat , this.long);

  @override
  _MechanicMapScreenState createState() => _MechanicMapScreenState();
}

class _MechanicMapScreenState extends State<MechanicMapScreen> {

  Completer<GoogleMapController> _controller = Completer();

  Location location = new Location();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  LocationData _locationData;
  var lat=null , long = null;

  Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 15), (Timer t) => getMechanicLocation());

    getCustomerLocation();
    getMechanicLocation();


  }

  getCustomerLocation(){
    Marker marker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      markerId: MarkerId("2"),
      infoWindow: InfoWindow(
          title: 'Customer'
      ),
      position: LatLng(
          double.parse(widget.lat),
          double.parse(widget.long)
      ),
    );

    markers[MarkerId("cust")] = marker;
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Track Mechanic'),
        ),
      ),
      body: SafeArea(
          child: lat!=null ? GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(double.parse(widget.lat), double.parse(widget.long)),
              zoom: 9.4746,
            ),
            markers: Set<Marker>.of(markers.values),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          )  : Center(
            child: CircularProgressIndicator(),
          )
      ),
    );
  }

  getMechanicLocation() async{

    _locationData = await LocationHandler.getLocation();
    lat = _locationData.latitude;
    long = _locationData.longitude;
    //addCustomMarker

    if(lat!=null && long!=null)
      addCustomerMarker(lat, long);

  }


  addCustomerMarker(lat , long){

    Marker marker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      markerId: MarkerId("2"),
      infoWindow: InfoWindow(
          title: 'Mechanic'
      ),
      position: LatLng(
         lat,
          long
      ),
    );

    markers[MarkerId("mechanic")] = marker;
    setState(() {
    });

  }


}
