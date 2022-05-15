import 'dart:async';

import 'package:logging/logging.dart';
import 'package:weather/weather.dart';

class WeatherForcastViewModel {
  final _log = Logger('Weather Forcast ViewModel');
  final String _key = '710614870e79aa7533019ef5cae42c24';
  late WeatherFactory weatherFactory;
  Future<List<Weather>?>? _rawData;
  String _latitude = '43.461165';
  String _longitude = '-80.525917';

  void initWeatherData() {
    weatherFactory = WeatherFactory(_key);
  }

  void fetchWeatherForcast() async {
    final double? lat = double.tryParse(_latitude);
    final double? lon = double.tryParse(_longitude);

    _rawData = weatherFactory.fiveDayForecastByLocation(lat!, lon!);
  }

  List<Weather> filterList(List<Weather> filterData) {
    List<Weather> result = [];

    DateTime? startDate = filterData.first.date;

    for (int i = 0; i < 5; i++) {
      Weather elements =
          filterData.where((item) => item.date == startDate).first;

      result.add(elements);
      startDate = startDate?.add(const Duration(days: 1));
    }
    for (Weather res in result) {
      _log.fine('Result: $res');
    }

    return result;
  }

  String get latitude => _latitude;

  String get longitude => _longitude;

  Future<List<Weather>?>? listOfFiveDayForcast() => _rawData;

  void updateLatitude(String latitude) {
    _latitude = latitude;
    _log.fine('NEW LAT:  $_latitude');
  }

  void updateLongitude(String longitude) {
    _longitude = longitude;
    _log.fine('NEW LONG:  $_longitude');
  }
}
