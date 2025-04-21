import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCity = "Bangkok";
  String weather = "";
  String description = "";

  final String apiKey = "fdba6a24c7cd5dfbf5435c662ed32afa";

  List<String> cities = ['Bangkok', 'Chiang Mai', 'Phuket', 'Khon Kaen'];

  Future<void> fetchWeather(String city) async {
    final url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        weather = "${data['main']['temp']}°C";
        description = data['weather'][0]['description'];
      });
    } else {
      setState(() {
        weather = "Error";
        description = "";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather(selectedCity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather in $selectedCity"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => LoginScreen()),
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(weather, style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
            Text(description, style: TextStyle(fontSize: 18)),
            const SizedBox(height: 24),
            DropdownButton<String>(
              value: selectedCity,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedCity = value;
                  });
                  fetchWeather(value);
                }
              },
              items: cities.map((String city) {
                return DropdownMenuItem(value: city, child: Text(city));
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
