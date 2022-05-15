import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

import 'weather_forcast_view_model.dart';

class WeatherForcastController extends ChangeNotifier {
  final WeatherForcastViewModel _weatherForcastViewModel;
  bool isButtonPressed = false;

  WeatherForcastController(this._weatherForcastViewModel) {
    _weatherForcastViewModel.initWeatherData();
  }

  String get latitude => _weatherForcastViewModel.latitude;

  String get longitude => _weatherForcastViewModel.longitude;

  Future<List<Weather>?>? get listOfFiveDaysForcast =>
      _weatherForcastViewModel.listOfFiveDayForcast();

  void updateLatitude(String latitude) {
    _weatherForcastViewModel.updateLatitude(latitude);
  }

  void updateLongitude(String longitude) {
    _weatherForcastViewModel.updateLongitude(longitude);
  }

  void fetchWeatherForcast() {
    _weatherForcastViewModel.fetchWeatherForcast();
    notifyListeners();
  }

  List<Weather> filterList(List<Weather> rawData) {
    return _weatherForcastViewModel.filterList(rawData);
  }
}
