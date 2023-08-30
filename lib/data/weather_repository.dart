import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:weather_app/data/weather_api_provider.dart';
import 'package:weather_app/model/weather_model.dart';

class WeatherRepository {
  WeatherApiProvider apiProvider = WeatherApiProvider();

  Future<Either<String, WeatherModel>> fetchWeatherData(String cityName) async {
    try {
      Response response = await apiProvider.getWeatherData(cityName);

      if (response.statusCode == 200) {
        WeatherModel weather = WeatherModel.fromJson(response.data);

        return right(weather);
      } else {
        return left('Oops! Invalid location.');
      }
    } catch (e) {
      return left('Oops! Invalid location.');
    }
  }
}
