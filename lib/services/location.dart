import 'package:geolocator/geolocator.dart';

class Location{
  var longitude;
  var latitude;
  Future<void> getLocation() async {
    try{
       Position position = await Geolocator
    .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    longitude=position.longitude;
    latitude=position.latitude;
      print(latitude);
    print(longitude);
    }
    catch(e){
      print(e);
    }
  }
}