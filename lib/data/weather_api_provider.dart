import 'package:dio/dio.dart';
import 'package:weather_app/constants.dart';

class WeatherApiProvider {
  Dio _dio = Dio();
  var apiKey = Constants.apiKey;

  Future<dynamic> getWeatherData(cityName) async {
    var response = await _dio
        .get('${Constants.baseUrl}/data/2.5/weather', queryParameters: {
      'q': cityName,
      'appid': apiKey,
      'units': 'metric',
    });

    print(response.statusCode);

    return response;
  }
}
