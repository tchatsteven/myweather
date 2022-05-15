import 'package:app/weather/weather_forcast_controller.dart';
import 'package:app/weather/weather_forcast_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather/weather.dart';

class WeatherForcastView extends StatelessWidget {
  const WeatherForcastView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => WeatherForcastController(WeatherForcastViewModel()),
        child: const _WeatherForcastScaffold());
  }
}

class _WeatherForcastScaffold extends StatelessWidget {
  const _WeatherForcastScaffold({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<WeatherForcastController>(context);
    final latTextFormController = TextEditingController();
    final longTextFormController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Weather Forcast',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            _coordinateInputs(
                vm, latTextFormController, longTextFormController),
            _button(vm),
            const Text(
              'Output:',
              style: TextStyle(fontSize: 20),
            ),
            const Divider(
              height: 20.0,
              thickness: 2.0,
            ),
            Expanded(child: _weatherResult(vm))
          ],
        ),
      ),
    );
  }

  Widget _coordinateInputs(
    WeatherForcastController vm,
    TextEditingController lat,
    TextEditingController lon,
  ) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
              margin: const EdgeInsets.all(5),
              child: TextFormField(
                initialValue: vm.latitude,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')),
                ],
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter latitude (Ex: 43.4643)',
                    hintStyle: TextStyle(fontSize: 12)),
                keyboardType: TextInputType.number,
                onChanged: (_) {
                  vm.updateLatitude(_);
                },
              )),
        ),
        Expanded(
            child: Container(
                margin: const EdgeInsets.all(5),
                child: TextFormField(
                  initialValue: vm.longitude,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')),
                  ],
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter longitude (Ex: 80.5204)',
                      hintStyle: TextStyle(fontSize: 12)),
                  keyboardType: TextInputType.number,
                  onChanged: (_) {
                    vm.updateLongitude(_);
                  },
                )))
      ],
    );
  }

  Widget _button(WeatherForcastController vm) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(5),
          child: TextButton(
            child: const Text(
              'Fetch weather',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              vm.fetchWeatherForcast();
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue)),
          ),
        ),
      ],
    );
  }

  Widget _weatherResult(WeatherForcastController vm) {
    return FutureBuilder<List<Weather>?>(
      future: vm.listOfFiveDaysForcast,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        final data = vm.filterList(snapshot.data!);

        return Center(
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Container(
                        height: 80,
                        width: 100,
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(DateFormat('EEE').format(data[index].date!)),
                            Image.network(
                              'http://openweathermap.org/img/w/${data[index].weatherIcon}.png',
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              //crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 4.0),
                                  child: Text(
                                    '${data[index].tempMax?.celsius?.toStringAsFixed(2)}\u2103',
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Text(
                                    '${data[index].tempMin?.celsius?.toStringAsFixed(2)}\u2103',
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ),
                              ],
                            )

                            // Icon(
                            //   Icons.audiotrack,
                            //   color: Colors.green,
                            //   size: 30.0,
                            // ),
                          ],
                        ));
                  },
                ),
              );
            },
            // separatorBuilder: (context, index) {
            //   return Divider();
            // },
          ),
        );
      },
    );
  }
}
