import 'package:flutter/material.dart';
import 'package:projeto_api_geo/Controller/city_db_controller.dart';
import 'package:projeto_api_geo/Controller/weather_controller.dart';
import 'package:projeto_api_geo/Model/city_model.dart';
import 'package:projeto_api_geo/Service/favorites_service.dart';
import 'details_weather_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final WeatherController _controller = WeatherController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cityController = TextEditingController();
  final CityDbController _dbController = CityDbController();
  final FavoritesService _favoritesService = FavoritesService();

  void _loadFavorites() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pesquisa Por Cidade")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Insira a Cidade"),
                      controller: _cityController,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Insira a Cidade";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _findCity(_cityController.text);
                        }
                      },
                      child: const Text("Pesquisar"),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: _dbController.listCities(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (_dbController.cities().isEmpty) {
                    return const Center(child: Text("Lista Vazia"));
                  } else {
                    return ListView.builder(
                      itemCount: _dbController.cities().length,
                      itemBuilder: (context, index) {
                        final city = _dbController.cities()[index];
                        return Dismissible(
                          key: Key(city.cityName),
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: const Icon(Icons.delete, color: Colors.white),
                          ),
                          onDismissed: (direction) {
                            _dbController.removeCity(city.cityName).then((_) {
                              setState(() {
                                _dbController.cities().removeAt(index);
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Cidade removida: ${city.cityName}'),
                                  action: SnackBarAction(
                                    label: 'Desfazer',
                                    onPressed: () {
                                      _dbController.addCity(city).then((_) {
                                        setState(() {
                                          _dbController.cities().insert(index, city);
                                        });
                                      });
                                    },
                                  ),
                                ),
                              );
                            });
                          },
                          child: ListTile(
                            title: Text(city.cityName),
                            onTap: () {
                              _findCity(city.cityName);
                            },
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _findCity(String city) async {
    if (await _controller.findCity(city)) {
      City cidade = City(cityName: city, favoriteCities: 0);
      await _favoritesService.addFavorite(cidade);
      print("ok");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Cidade Encontrada!"),
          duration: Duration(seconds: 1),
        ),
      );
      setState(() {});
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => DetailsWeatherScreen(city: city, onFavoritesUpdated: _loadFavorites),
        ),
      ).then((_) {
        _loadFavorites();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Cidade não Encontrada!"),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}