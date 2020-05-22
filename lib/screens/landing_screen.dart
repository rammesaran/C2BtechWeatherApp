import 'package:c2b_weatherapp/model/weather_model.dart';
import 'package:c2b_weatherapp/screens/home_page.dart';
import 'package:flutter/material.dart';



class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {


  @override
  void initState() {
    super.initState();
    getlocation();
  }

  void getlocation() async {
    WeatherModel weatherModel = WeatherModel();
    var weatherdata = await weatherModel.getLocationWeather();
    
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return HomePageScreen(
         locationscreen: weatherdata
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
       child: Image.network('https://www.c2btech.com/uploads/settings/15785731205931.png'),
      ),
    );
  }
}