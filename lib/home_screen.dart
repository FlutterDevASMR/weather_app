import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/bloc/weather_event.dart';
import 'package:weather_app/bloc/weather_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Container(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search a City',
                        icon: Icon(Icons.location_on),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.indigo,
                    child: IconButton(
                      onPressed: () {
                        if (controller.text != '') {
                          BlocProvider.of<WeatherBloc>(context)
                              .add(LoadWeatherEvent(controller.text));
                        }
                      },
                      icon: Icon(Icons.search),
                    ),
                  ),
                ],
              ),
              BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherInit) {
                    return Container();
                  }
                  if (state is WeatherLoading) {
                    return CircularProgressIndicator();
                  }
                  if (state is WeatherResponse) {
                    return state.either.fold(
                      (errorMessage) {
                        return Column(
                          children: [
                            Icon(
                              Icons.error,
                              size: 120,
                              color: Colors.red,
                            ),
                            SizedBox(height: 20),
                            Text(
                              errorMessage,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                      },
                      (weather) {
                        return Column(
                          children: [
                            Image.network(
                              weather.icon,
                              scale: 0.5,
                              color: Colors.indigo,
                              filterQuality: FilterQuality.high,
                            ),
                            Row(
                              children: [
                                Text(
                                  weather.temp.toString(),
                                  style: TextStyle(
                                    fontSize: 70,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '°C',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                            Text(
                              weather.description.capitalize(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 60),
                            Row(
                              children: [
                                SizedBox(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.water_drop,
                                        color: Colors.indigo,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            '${weather.humidity}%',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'Humidity',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.air,
                                        color: Colors.indigo,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            '${weather.windSpeed}Km/h',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'Wind Speed',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                            ),
                            SizedBox(height: 20),
                          ],
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
