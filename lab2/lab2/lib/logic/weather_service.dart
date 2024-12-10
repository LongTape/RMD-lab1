import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = 'b4e16e261b1cfa3b598a5845b2e30b9e';
  final String apiUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<Map<String, dynamic>> fetchWeather(String cityName) async {
    final response = await http.get(Uri.parse('$apiUrl?q=$cityName&appid=$apiKey'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }

  Future<Map<String, dynamic>> fetchCurrentWeather(String city) async {
    // Імітація отримання поточних даних про погоду
    await Future.delayed(Duration(seconds: 2));
    return {
      'temperature': 20,
      'description': 'Clear sky',
    };
  }

  Future<List<Map<String, dynamic>>> fetchWeeklyForecast(String city) async {
    // Імітація отримання даних прогнозу на тиждень
    await Future.delayed(Duration(seconds: 2));
    return List.generate(7, (index) {
      return {
        'day': 'Day ${index + 1}',
        'temperature': 20 + index,
        'description': 'Partly cloudy',
      };
    });
  }
}