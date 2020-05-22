
import 'package:c2b_weatherapp/services/get_location.dart';
import 'package:c2b_weatherapp/services/weather_data.dart';

const apikey = 'f281424d5defc4a87018350c04692e28';
const weatherurl = 'http://api.weatherstack.com/current';
class WeatherModel {
Future<dynamic> getinputlocation(String cityname) async
{
  var url ='$weatherurl?access_key=$apikey&query=$cityname&unites=m';
  WeatherData weather =  WeatherData(url);
  var weatherresult = await weather.getnetworkweather();
  return weatherresult;
}

Future<dynamic> getLocationWeather() async
{
  Location location = Location();
    await location.getuserlocation();

      var url ='$weatherurl?access_key=$apikey&query=';
    WeatherData networkingWeather = WeatherData(
        '$url${location.latitiude},${location.longitiude}&units=m');

    var weatherdata = await networkingWeather.getnetworkweather();
    return weatherdata;
}




  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🌞 time';
    } else if (temp < 20) {
      return 'Time for shorts and 👕';
    } else if (temp <= 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}