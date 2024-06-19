import 'package:projeto_api_geo/Model/city_model.dart';
import 'package:projeto_api_geo/Service/city_db_service.dart';

class CityDbController {
  //atributo
  List<City> _cities = [];
  final CityDataBaseService _dbService = CityDataBaseService();
  //get
  List<City> cities() => _cities;

  //métodos
  //List<Cities> 
  Future<List<City>> listCities() async{
    List<Map<String,dynamic>> maps = await _dbService.getAllCities();
    _cities = maps.map<City>((e) => City.fromMap(e)).toList();
    return _cities;
  }
  //adicionar tarefas
  Future<void> addCities(City city) async{
    _dbService.insertCity(city);
  }

// Método para deletar uma cidade
  Future<void> deleteCity(City city) async {
    await _dbService.deleteCity(city.cityName);
    _cities.remove(city); // Remove a cidade da lista local
  }
}