import 'Restaurant.dart';

class RestaurantsResponse {
  List<Restaurant> restaurants;

  RestaurantsResponse({this.restaurants});

  RestaurantsResponse.fromJson(Map<String, dynamic> json) {
    if (json['restaurants'] != null) {
      restaurants = new List<Restaurant>();
      json['restaurants'].forEach((v) {
        restaurants.add(new Restaurant.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.restaurants != null) {
      data['restaurants'] = this.restaurants.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
