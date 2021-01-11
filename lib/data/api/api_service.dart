import 'dart:convert';

import 'package:restaurant_app/data/model/Restaurant.dart';
import 'package:restaurant_app/data/model/restaurants_response.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final String _baseURL = "https://restaurant-api.dicoding.dev";
  static final String _listURL = "/list";
  static String _detailURL(String id) => "/detail/$id";
  static String _searchURL(String query) => "/search?q=$query";

  Future<RestaurantsResponse> list() async {
    final response = await http.get(_baseURL + _listURL);
    if (response.statusCode == 200) {
      return RestaurantsResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load");
    }
  }

  Future<RestaurantsResponse> search(String query) async {
    final response = await http.get(_baseURL + _searchURL(query));
    if (response.statusCode == 200) {
      return RestaurantsResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load");
    }
  }

  Future<Restaurant> detail(String id) async {
    final response = await http.get(_baseURL + _detailURL(id));
    if (response.statusCode == 200) {
      return Restaurant.fromJson(json.decode(response.body)["restaurant"]);
    } else {
      throw Exception("Failed to load");
    }
  }
}
