import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  final WeatherData;
  LocationScreen(this.WeatherData);
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  var temp;
  String city;
  int condition;
  var name;
  var cityData;
  WeatherModel weatherModel=WeatherModel();
  void updateUI(dynamic weather) {
    temp = weather['main']['temp'];
    city = weather['name'];
    condition = weather['weather'][0]['id'];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.WeatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async{
                      var da=await weatherModel.getLocationWeather();
                      updateUI(da);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async{
                      name=await Navigator.push(context, MaterialPageRoute(builder:(context){
                        return CityScreen();
                      },
                      ),
                      );
                       if(name!=null){
                        cityData=await weatherModel.getCityWeather(name);
                        setState(() {
                          updateUI(cityData);
                        });
                       }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      temp.toInt().toString(),
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherModel.getWeatherIcon(condition),
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  weatherModel.getMessage(temp.toInt()),
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
