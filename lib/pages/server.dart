// Server
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum(String city) async {
  final response = await http.get(Uri.parse(
      'http://api.openweathermap.org/data/2.5/weather?q=${city}&appid=2f0b46596dcb9d0285774ff687400379'));

  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Album');
  }
}

class Album {
  //final String coord;
  final String weather_icon;
  final String weather_description;
  final double temp;
  final String city_name;

  Album({
    //required this.coord,
    required this.weather_icon,
    required this.weather_description,
    required this.temp,
    required this.city_name,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
        //coord: json['coord']['lat'].toString(),
        weather_icon: json['weather'][0]['icon'],
        weather_description: json['weather'][0]['description'],
        temp: json['main']['temp'],
        city_name: json['name']);
  }
}
