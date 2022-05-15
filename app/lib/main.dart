import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import 'weather/weather_forcast_view.dart';

void main() {
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    var logger = Logger('main');
    logger.fine('${record.level.name}: ${record.time}: ${record.message}');
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Forcast',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WeatherForcastView(),
    );
  }

  int dummyF(int value) {
    return value * 10;
  }
}
