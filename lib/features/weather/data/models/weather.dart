class Weather {
  const Weather({
    required this.city,
    required this.temp,
    required this.sky,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        city: json['name'],
        temp: json['main']['temp'],
        sky: json['weather'][0]['main'],
        description: json['weather'][0]['description'],
        icon: json['weather'][0]['icon'],
      );

  final String city;
  final double temp;
  final String sky;
  final String description;
  final String icon;
}
