import 'package:flutter/material.dart';
import 'package:projeto_api_geo/Controller/city_db_controller.dart'; // Importe os controladores necessários
import 'package:projeto_api_geo/Model/city_model.dart'; // Importe os modelos necessários
import 'package:projeto_api_geo/Controller/weather_controller.dart'; // Importe os controladores necessários
import 'details_weather_screen.dart'; // Importe a tela de detalhes já existente

class FavoritesScreen extends StatelessWidget {
  final CityDbController _dbController = CityDbController(); // Controlador para acessar os dados do banco
  final WeatherController _weatherController = WeatherController(); // Controlador para acessar os dados do clima

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cidades Favoritas'),
      ),
      body: FutureBuilder<List<City>>(
        future: _dbController.listCities(), // Chama o método para obter a lista de cidades favoritas
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar dados.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhuma cidade favorita.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                final city = snapshot.data?[index];
                return ListTile(
                  title: Text(city!.cityName),
                  onTap: () => _openDetailsScreen(context, city.cityName),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<void> _openDetailsScreen(BuildContext context, String cityName) async {
    if (await _weatherController.findCity(cityName)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsWeatherScreen(city: cityName),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cidade não encontrada!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}