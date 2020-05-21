import 'package:c2b_weatherapp/model/weather_model.dart';
import 'package:c2b_weatherapp/screens/city_page.dart';
import 'package:c2b_weatherapp/utiles/constant.dart';
import 'package:flutter/material.dart';


class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationscreen});
  final locationscreen;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  int temparture;
  String description;
  String cityname;
  List<dynamic> weatherdescription;
  List<dynamic> weathericons;
  String stringweathericons;
  String errortype;

  @override
  void initState() {
    super.initState();
    updateWeater(widget.locationscreen);
  }

void updaterror(dynamic weatherdata){

  setState(() {
     temparture = 0;
        description = 'unable to get data';
        cityname = '';
        errortype = weatherdata['error']['type'];
        weatherdescription =['Please enter valid name'];
  });
}

  void updateWeater(dynamic weatherdata) {
    
    setState(() {
      if ( weatherdata['success']== 'false') {
        temparture = 0;
        description = 'unable to get data';
        cityname = 'Error occured';
        weatherdescription = weatherdata['error']['type'];
        weathericons = ["Error occured"];

        return;
      }
        
      try{
       {
          var temp = weatherdata['current']['temperature'];
            temparture = temp;

 

       description = weatherModel.getMessage(temparture);

      cityname = weatherdata['location']['name'];
      weatherdescription = weatherdata['current']['weather_descriptions'];
      weathericons = weatherdata['current']['weather_icons'];
       stringweathericons = weathericons.join();
        }
     

      }
      catch(e){
        print(e);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black12,
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
                    onPressed: () async {
                      var locationdata =
                          await weatherModel.getLocationWeather();
                      updateWeater(locationdata);
                    },
                    child: Icon(
                      Icons.gps_fixed,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async{
                     var getweather=  await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {

                          return CityPage();
                        }),
                      );
                        if(getweather != null  )
                        {
                          var weatherdata = await weatherModel.getinputlocation(getweather);
                          if(weatherdata['success']== false)
                          {
                            print('Invalid request');
                            updaterror(weatherdata);
                            
                          }else{
                           updateWeater(weatherdata);

                          }
                        }
                    },
                    child: Icon(
                      Icons.search,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 15.0,
                ),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        temparture.toString() ?? "",
                        style: kTempTextStyle,
                      ),
                    ),
                   Container(
                     child:  Image.network(stringweathericons),
                   ),
                       
                    
                  ],
                ),
              ),

               Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(  weatherdescription.join().toString() ?? "empty",
                  
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),

              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$description in $cityname" ?? "",
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