import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/detail/page/detail_page.dart';

import 'ui/home/page/home_page.dart';
import 'ui/search/page/search_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider<RestaurantProvider>(
      create: (_) => RestaurantProvider(
        apiService: ApiService(),
      ),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.orange[800],
        accentColor: Colors.orange[600],
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => HomePage(),
        DetailPage.routeName: (context) => DetailPage(
              idRestaurant: ModalRoute.of(context).settings.arguments,
            ),
        SearchPage.routeName: (context) => SearchPage()
      },
    );
  }
}
