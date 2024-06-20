import 'package:projeto_api_geo/Model/city_model.dart';
import 'package:projeto_api_geo/Service/city_db_service.dart';

class CityDbController {
  final CityDataBaseService _dbService = CityDataBaseService();

  List<City> _cities = [];

  Future<void> addCity(City city) async {
    await _dbService.insertCity(city);
    await listCities();
  }

  Future<void> removeCity(String cityName) async {
    await _dbService.deleteCity(cityName);
    await listCities();
  }

  Future<void> listCities() async {
    final maps = await _dbService.getAllCities();
    _cities = maps.map((map) => City.fromMap(map)).toList();
  }

  List<City> cities() {
    return _cities;
  }
}