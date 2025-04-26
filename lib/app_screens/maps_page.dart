import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;


class GetAddress extends StatefulWidget {
  @override
  _GetAddressState createState() => _GetAddressState();
}

class _GetAddressState extends State<GetAddress> {
  final loc.Location location = loc.Location();
  @override
  Widget build(BuildContext context) {
    Future <void>fetchloaction() async{
      loc.Location location = loc.Location();
      bool service_enabled = await location.serviceEnabled();
      if(!service_enabled){
        service_enabled = await location.requestService();
        if (!service_enabled) {
          throw Exception("Location service is disabled.");
        }
      }
      loc.PermissionStatus permissiongranted = await location.hasPermission();
      if(permissiongranted== loc.PermissionStatus.denied){
        permissiongranted= await location.requestPermission();
        if (permissiongranted != loc.PermissionStatus.granted) {
          throw Exception("Location permission not granted.");
        }
      }
      loc.LocationData locationData = await location.getLocation();

      List<Placemark> placemark = await placemarkFromCoordinates(locationData.latitude!, locationData.longitude!);
      Placemark place =placemark[0];
    }
  return Scaffold(

  );
  }



}
