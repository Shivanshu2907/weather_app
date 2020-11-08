import 'package:clima/services/networking.dart';
import 'package:clima/services/location.dart';

const apiKey = '1e13765e846cc3da1f4a40c760a6b8ac';

class WeatherModel {

Future<dynamic> getCityWeather(name) async{
   NetworkData nd = NetworkData(
        'https://api.openweathermap.org/data/2.5/weather?q=$name&appid=$apiKey&units=metric');
    var d = await nd.getResponse();
    return d;
}

Future<dynamic> getLocationWeather() async {
  var latitude;
  var longitude;

  Location location = Location();
    await location.getLocation();
    latitude = location.latitude;
    longitude = location.longitude;
  
    NetworkData nd = NetworkData(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');
    var d = await nd.getResponse();
    print(d['main']['temp']);
    return d;
}

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}

