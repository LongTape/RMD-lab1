import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {
  final String apiKey = 'b4e16e261b1cfa3b598a5845b2e30b9e';  // Ваш API ключ

  // Функція для отримання поточної погоди
  Future<Map<String, dynamic>> fetchCurrentWeather(String city) async {
    final url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'description': data['weather'][0]['description'],
          'temperature': data['main']['temp'] - 273.15, // Перетворення Кельвін в Цельсій
        };
      } else {
        throw Exception('Failed to load weather');
      }
    } catch (e) {
      throw Exception('Error fetching weather: $e');
    }
  }

  // Функція для отримання прогнозу на тиждень
  Future<List<dynamic>> fetchWeeklyForecast(String city) async {
    final url = Uri.parse('https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['list']; // Прогноз на 5 днів (по 3 години)
      } else {
        throw Exception('Failed to load weather forecast');
      }
    } catch (e) {
      throw Exception('Error fetching weekly forecast: $e');
    }
  }
}