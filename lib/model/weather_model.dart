class WeatherModel {
  int temp;
  String description;
  int humidity;
  int windSpeed;
  String icon;

  WeatherModel({
    required this.temp,
    required this.description,
    required this.humidity,
    required this.windSpeed,
    required this.icon,
  });

  factory WeatherModel.fromJson(json) {
    return WeatherModel(
      temp: json['main']['temp'].toInt(),
      description: json['weather'][0]['description'],
      humidity: json['main']['humidity'].toInt(),
      windSpeed: json['wind']['speed'].toInt(),
      icon:
          'https://openweathermap.org/img/wn/${json['weather'][0]['icon']}@2x.png',
    );
  }
}
