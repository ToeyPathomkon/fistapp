import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedProvince = 'Bangkok';
  Map<String, dynamic>? weatherData;

  final provinces = ['Bangkok', 'Chiang Mai', 'Phuket', 'Khon Kaen'];

  Future<void> fetchWeather() async {
    const apiKey = 'fdba6a24c7cd5dfbf5435c662ed32afa'; // เปลี่ยนตรงนี้เป็น API KEY จริงจาก openweathermap.org
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$selectedProvince,TH&appid=$apiKey&units=metric');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        weatherData = json.decode(response.body);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load weather data')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather Info')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedProvince,
              items: provinces
                  .map((prov) => DropdownMenuItem(
                        value: prov,
                        child: Text(prov),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedProvince = value!;
                });
                fetchWeather();
              },
            ),
            const SizedBox(height: 20),
            if (weatherData != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('จังหวัด: $selectedProvince'),
                  Text('อุณหภูมิ: ${weatherData!['main']['temp']}°C'),
                  Text('สภาพอากาศ: ${weatherData!['weather'][0]['main']}'),
                  Text('ความชื้น: ${weatherData!['main']['humidity']}%'),
                ],
              )
            else
              const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
