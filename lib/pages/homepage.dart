// Home Page
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cityforecast.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextStyle titlestyle =
      GoogleFonts.adventPro(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold);
  TextStyle normalstyle =
      GoogleFonts.adventPro(fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff252525),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            pinned: true,
            expandedHeight: 160,
            backgroundColor: Colors.teal[800],
            flexibleSpace: FlexibleSpaceBar(
              background: DecoratedBox(
                position: DecorationPosition.foreground,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    colors: [
                      Colors.teal[800]!,
                      Colors.transparent,
                    ],
                    ),
                ),
                child: Image(
                image: AssetImage('assets/clouds.jpg'),
                fit: BoxFit.cover,
              ),
                ),
                centerTitle: true,
              title: Text(
                'Weather Forecast',
                style: titlestyle,
              ),
            ),
          ),

          CityForecast(),
        ],
      ),
    );
  }
}
