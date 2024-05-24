import 'package:flutter/foundation.dart';

class City {
  //atributos
  final String cityName;
  final bool favoriteCities;

  City({required this.cityName, 
  required this.favoriteCities});

  Map<String, dynamic> toMap()=>{
    'cityName': cityName,
    'favoriteCities': favoriteCities
  };

  factory City.fromMap(Map<String, dynamic> map){
    return City(
      cityName: map['cityname'],
      favoriteCities: map['favoritecities']
    );
  }
}