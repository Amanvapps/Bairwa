import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gomechanic/services/MapService.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomerMapScreen extends StatefulWidget {
  var mechanicId;
  CustomerMapScreen(this.mechanicId);

  @override
  _CustomerMapScreenState createState() => _CustomerMapScreenState();
}

class _CustomerMapScreenState extends State<CustomerMapScreen> {

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

    getMechanicLocation();

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
              target: LatLng(double.parse(lat), double.parse(long)),
              zoom: 14.4746,
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

    print("----------------");

    //hit api....
    var obj = await MapService.getMechanicLocation(widget.mechanicId);
     lat = obj['latitude'];
     long = obj['longitude'];
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
         double.parse(lat),
          double.parse(long)
      ),
    );

    markers[MarkerId("cust")] = marker;
    setState(() {
    });

  }


}
