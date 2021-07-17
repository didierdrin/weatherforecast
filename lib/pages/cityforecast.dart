// City Forecast
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'server.dart';

class CityForecast extends StatefulWidget {
  const CityForecast({Key? key}) : super(key: key);

  @override
  _CityForecastState createState() => _CityForecastState();
}

class _CityForecastState extends State<CityForecast> {
   TextStyle titlestyle =
      GoogleFonts.adventPro(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold);
  TextStyle normalstyle =
      GoogleFonts.adventPro(fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal);
   TextStyle tempstyle =
      GoogleFonts.adventPro(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold);

  final TextEditingController _controller = TextEditingController();
  Future<Album>? _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return (_futureAlbum == null) ? initialPage() : buildFutureBuilder();
        },
        childCount: 1,
      ),
    );
  }

  initialPage() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextField(
            style: GoogleFonts.adventPro(fontSize: 20),
            controller: _controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              hintText: 'City Name',
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.search,
                  size: 25,
                  color: Colors.teal[800],
                ),
                onPressed: () {
                  setState(() {
                    _futureAlbum = fetchAlbum(_controller.text);
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  FutureBuilder<Album> buildFutureBuilder() {
    return FutureBuilder<Album>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(padding: EdgeInsets.all(10), child: Card(elevation: 5, child: Row(children: [
            SizedBox(
              width: 100,
              height: 100,
              child: Image.network('http://openweathermap.org/img/wn/${snapshot.data!.weather_icon}@2x.png'),
            ),
            Expanded(child: Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('${snapshot.data!.city_name}', style: titlestyle,),
                SizedBox(height: 5,),
                Text('${snapshot.data!.weather_description}', style: normalstyle,),
              ],),
            )),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: SizedBox(
                child: Text('${(snapshot.data!.temp - 273.15).toStringAsFixed(2)}', style: tempstyle,),
              ),
            ),
          ],),),);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
