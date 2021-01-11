import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/Restaurant.dart';
import 'package:restaurant_app/data/model/drinks.dart';
import 'package:restaurant_app/data/model/foods.dart';
import 'package:restaurant_app/data/model/restaurants_response.dart';
import 'package:restaurant_app/ui/detail/page/detail_page.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  RestaurantProvider({
    @required this.apiService,
  });

  RestaurantsResponse _restaurantsResponse;
  RestaurantsResponse _restaurantsSearchResponse;

  String _message;
  String _messageSearch;

  ResultState _state;
  ResultState _stateSearch;

  Restaurant _restaurant;
  String _messageDetail;
  ResultState _stateDetail;
  String _menuType;

  RestaurantsResponse get restaurants => _restaurantsResponse;
  RestaurantsResponse get restaurantsSearch => _restaurantsSearchResponse;

  String get message => _message;
  ResultState get state => _state;
  String get messageSearch => _messageSearch;
  ResultState get stateSearch => _stateSearch;

  Restaurant get restaurant => _restaurant;
  String get messageDetail => _messageDetail;
  ResultState get stateDetail => _stateDetail;
  List<Foods> get menuFoods => _restaurant.menus.foods;
  List<Drinks> get menuDrinks => _restaurant.menus.drinks;
  String get menuType => _menuType;

  dynamic get dataMenu {
    if (_menuType == null) {
      return _restaurant.menus.foods;
    } else if (_menuType == DRINKS) {
      return _restaurant.menus.drinks;
    } else if (_menuType == FOODS) {
      return _restaurant.menus.foods;
    }
  }

  setMenu(String menuType) {
    if (menuType != null) {
      _menuType = menuType;
      notifyListeners();
    }
  }

  fetchRestaurants() async {
    try {
      _state = ResultState.Loading;
      final restaurant = await apiService.list();
      notifyListeners();
      if (restaurant != null) {
        if (!restaurant.error) {
          _state = ResultState.HasData;
          _restaurantsResponse = restaurant;
          notifyListeners();
        } else {
          _state = ResultState.Error;
          _message = restaurant.message;
          notifyListeners();
        }
      } else {
        _state = ResultState.NoData;
        _message = "Empty data";
        notifyListeners();
      }
    } on SocketException {
      _state = ResultState.Error;
      notifyListeners();
      _message = 'Periksa Koneksi Internet Anda!';
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      _message = "Error: $e";
    }
  }

  searhRestaurants(String query) async {
    if (query.isNotEmpty) {
      try {
        _stateSearch = ResultState.Loading;

        final restaurantSearch = await apiService.search(query);
        notifyListeners();
        if (restaurantSearch.restaurants.length != 0) {
          if (!restaurantSearch.error) {
            _stateSearch = ResultState.HasData;
            _restaurantsSearchResponse = restaurantSearch;
            notifyListeners();
          } else {
            _stateSearch = ResultState.Error;
            _messageSearch = restaurantSearch.message;
            notifyListeners();
          }
        } else {
          _stateSearch = ResultState.NoData;
          _messageSearch = "Tidak ditemukan";
          notifyListeners();
        }
      } on SocketException {
        _stateSearch = ResultState.Error;
        _messageSearch = 'Periksa Koneksi Internet Anda!';
        notifyListeners();
      } catch (e) {
        _stateSearch = ResultState.Error;
        _messageSearch = "Error: $e";
        notifyListeners();
      }
    } else {
      _stateSearch = null;
      _messageSearch = null;
      notifyListeners();
    }
  }

  fetchDetailRestaurants(String idRestaurant) async {
    try {
      _stateDetail = ResultState.Loading;
      final restaurant = await apiService.detail(idRestaurant);
notifyListeners();
      if (restaurant == null) {
        _stateDetail = ResultState.NoData;
        _messageDetail = "Empty data";
        notifyListeners();
      } else {
        _stateDetail = ResultState.HasData;
        _restaurant = restaurant;
        notifyListeners();
      }
    } on SocketException {
      _stateDetail = ResultState.Error;
      _messageDetail = 'Periksa Koneksi Internet Anda!';
      notifyListeners();
    } catch (e) {
      _stateDetail = ResultState.Error;
      _messageDetail = "Error: $e";
      notifyListeners();
    }
  }
}
