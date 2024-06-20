import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projeto_api_geo/Controller/weather_controller.dart';
import 'package:projeto_api_geo/Model/city_model.dart';
import 'package:projeto_api_geo/Service/city_db_service.dart';
import 'package:projeto_api_geo/Service/favorites_service.dart';
import 'package:weather_icons/weather_icons.dart'; // Importando ícones de clima

class DetailsWeatherScreen extends StatefulWidget {
  final String city;
  final VoidCallback onFavoritesUpdated;

  const DetailsWeatherScreen({
    super.key,
    required this.city,
    required this.onFavoritesUpdated,
  });

  @override
  State<DetailsWeatherScreen> createState() => _DetailsWeatherScreenState();
}

class _DetailsWeatherScreenState extends State<DetailsWeatherScreen> {
  final WeatherController _controller = WeatherController();
  final FavoritesService _favoritesService = FavoritesService();
  bool isFavorite = false; // Variável de estado para controlar se é favorito

  final Map<String, String> weatherTranslations = {
    "clear sky": "Céu limpo",
    "few clouds": "Poucas nuvens",
    "scattered clouds": "Nuvens dispersas",
    "broken clouds": "Nuvens quebradas",
    "shower rain": "Chuva de banho",
    "rain": "Chuva",
    "thunderstorm": "Trovoada",
    "snow": "Neve",
    "mist": "Névoa"
  };

  final Map<String, Color> weatherBackgroundColors = {
    "clear sky": Colors.blue,
    "few clouds": Colors.lightBlueAccent,
    "scattered clouds": Colors.blueGrey,
    "broken clouds": Colors.grey,
    "shower rain": Colors.indigo,
    "rain": Colors.blueAccent,
    "thunderstorm": Colors.deepPurple,
    "snow": Colors.white,
    "mist": Colors.blueGrey[200]!,
  };

  String translateWeather(String description) {
    return weatherTranslations[description.toLowerCase()] ?? description;
  }

 


  Color getBackgroundColor(String description) {
    return weatherBackgroundColors[description.toLowerCase()] ?? Colors.blue;
  }

  @override
  void initState() {
    super.initState();
    _checkFavorite();
  }

  Future<void> _checkFavorite() async {
    final favorite = await _favoritesService.isFavorite(City(cityName: widget.city, favoriteCities: 0));
    setState(() {
      isFavorite = favorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Tempo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: FutureBuilder(
            future: _controller.getWeather(widget.city),
            builder: (context, snapshot) {
              if (_controller.weatherList.isEmpty) {
                return const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                );
              } else {
                final weather = _controller.weatherList.last;
                final backgroundColor = getBackgroundColor(weather.description);
                return Container(
                  color: backgroundColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            weather.name,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.white,
                            ),
                            onPressed: () async {
                              if (isFavorite) {
                                await _favoritesService.removeFavorite(City(cityName: weather.name, favoriteCities: 0));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Cidade removida dos favoritos.'),
                                  ),
                                );
                              } else {
                                await _favoritesService.addFavorite(City(cityName: weather.name, favoriteCities: 0));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Cidade adicionada aos favoritos.'),
                                  ),
                                );
                              }
                              setState(() {
                                isFavorite = !isFavorite; // Inverte o estado de favorito
                              });
                              widget.onFavoritesUpdated();
                            },
                          )
                        ],
                      ),
                      Text(
                        translateWeather(weather.description),
                        style: const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Text(
                        'Temperatura: ${(weather.temp - 273).toStringAsFixed(2)}°C',
                        style: const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
