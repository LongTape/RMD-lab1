import 'package:flutter/material.dart';
import 'package:lab2/logic/weather_service.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();
  String cityName = 'London';
  String weatherData = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Enter city name'),
              onChanged: (value) {
                cityName = value;
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () async {
                      setState(() {
                        isLoading = true;
                        weatherData = '';
                      });

                      try {
                        final data = await _weatherService.fetchWeather(cityName);
                        setState(() {
                          weatherData = 'Temp: ${data['main']['temp']}°C\n'
                              'Weather: ${data['weather'][0]['description']}';
                        });
                      } catch (e) {
                        setState(() {
                          weatherData = 'Error: $e';
                        });
                      } finally {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
              child: isLoading ? CircularProgressIndicator() : Text('Get Weather'),
            ),
            SizedBox(height: 20),
            Text(weatherData, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
