import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';
import 'package:lab2/data/repositories/user_repoisitory.dart';
import 'package:lab2/logic/weather_service.dart';

class HomeScreen extends StatefulWidget {
  final UserRepository userRepository;

  HomeScreen({required this.userRepository});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late StreamSubscription _connectivitySubscription;
  bool _isOffline = false;
  String? _weatherDescription;
  double? _temperature;
  String? _city = 'Kyiv'; // За замовчуванням місто Київ
  List<dynamic> _weeklyForecast = [];

  final WeatherService _weatherService = WeatherService();

  @override
  void initState() {
    super.initState();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        _isOffline = result == ConnectivityResult.none;
      });

      if (_isOffline) {
        _showNoInternetDialog();
      } else {
        _fetchWeather();
        _fetchWeeklyForecast();
      }
    });

    if (!_isOffline) {
      _fetchWeather();
      _fetchWeeklyForecast();
    }
  }
  Future<void> _fetchWeather() async {
    try {
      final weather = await _weatherService.fetchCurrentWeather(_city!);
      setState(() {
        _weatherDescription = weather['description'];
        _temperature = weather['temperature'];
      });
    } catch (e) {
      print('Error fetching weather: $e');
    }
  }
  Future<void> _fetchWeeklyForecast() async {
    try {
      final forecast = await _weatherService.fetchWeeklyForecast(_city!);
      setState(() {
        _weeklyForecast = forecast;
      });
    } catch (e) {
      print('Error fetching weekly forecast: $e');
    }
  }
  void _showNoInternetDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('No Internet'),
        content: Text('You are offline. Some features may not be available.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
 
  Widget _buildOfflineLayer() {
    if (_isOffline) {
      return Container(
        color: Colors.black.withOpacity(0.5),
        alignment: Alignment.center,
        child: Text(
          'Offline Mode',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      );
    }
    return SizedBox.shrink();
  }

  Widget _buildWeeklyForecast() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const <DataColumn>[
          DataColumn(label: Text('Day')),
          DataColumn(label: Text('Temperature (°C)')),
          DataColumn(label: Text('Description')),
        ],
        rows: _weeklyForecast.map<DataRow>((forecast) {
          final dateTime = DateTime.fromMillisecondsSinceEpoch(forecast['dt'] * 1000);
          final temperature = forecast['main']['temp'] - 273.15;
          final description = forecast['weather'][0]['description'];

          return DataRow(cells: [
            DataCell(Text('${dateTime.day}/${dateTime.month}')),
            DataCell(Text('${temperature.toStringAsFixed(1)}°C')),
            DataCell(Text(description)),
          ]);
        }).toList(),
      ),
    );
  }

  Widget _buildCitySelector() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: (value) {
          setState(() {
            _city = value;
          });
          _fetchWeather();
          _fetchWeeklyForecast();
        },
        decoration: InputDecoration(
          labelText: 'Enter city name',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCitySelector(),  // Додаємо поле для вибору міста
                if (_isOffline)
                  ElevatedButton(
                    onPressed: null,
                    child: Text('Go to Profile (Offline)'),
                  )
                else
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/profile'),
                    child: Text('Go to Profile'),
                  ),
                if (_weatherDescription != null && _temperature != null)
                  Column(
                    children: [
                      Text('Weather in $_city'),
                      Text('Temperature: ${_temperature!.toStringAsFixed(1)}°C'),
                      Text('Description: $_weatherDescription'),
                    ],
                  ),
                if (_weatherDescription == null && !_isOffline)
                  CircularProgressIndicator(),
                SizedBox(height: 20),
                Text('Weekly Forecast:'),
                if (_weeklyForecast.isNotEmpty)
                  _buildWeeklyForecast(),
              ],
            ),
          ),
          _buildOfflineLayer(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
}