import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab2/logic/weather_service.dart';

class WeatherState {
  final String city;
  final Map<String, dynamic>? currentWeather;
  final List<dynamic> weeklyForecast;
  final bool isLoading;
  final String? errorMessage;

  WeatherState({
    required this.city,
    this.currentWeather,
    this.weeklyForecast = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  WeatherState copyWith({
    String? city,
    Map<String, dynamic>? currentWeather,
    List<dynamic>? weeklyForecast,
    bool? isLoading,
    String? errorMessage,
  }) {
    return WeatherState(
      city: city ?? this.city,
      currentWeather: currentWeather ?? this.currentWeather,
      weeklyForecast: weeklyForecast ?? this.weeklyForecast,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherService weatherService;

  WeatherCubit(this.weatherService)
      : super(WeatherState(city: 'Kyiv'));

  void updateCity(String city) {
    emit(state.copyWith(city: city));
    fetchWeather();
    fetchWeeklyForecast();
  }

  Future<void> fetchWeather() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final weather = await weatherService.fetchCurrentWeather(state.city);
      emit(state.copyWith(currentWeather: weather, isLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  Future<void> fetchWeeklyForecast() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final forecast = await weatherService.fetchWeeklyForecast(state.city);
      emit(state.copyWith(weeklyForecast: forecast, isLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }
}
