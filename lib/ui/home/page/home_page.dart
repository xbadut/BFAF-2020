import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurants_response.dart';
import 'package:restaurant_app/ui/home/widget/item_restaurant.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<RestaurantsResponse> loadDataRestaurants() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/local_restaurant.json");
    final jsonResult = json.decode(data);
    return RestaurantsResponse.fromJson(jsonResult);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverAppBar(
              title: Text(isScrolled ? "Restaurant" : ""),
              elevation: 0,
              pinned: true,
              actions: [Icon(Icons.search)],
              expandedHeight: 160,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  padding: EdgeInsets.all(28),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Restaurant",
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      Text(
                        "Recomended restaurant for you!",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: FutureBuilder(
          future: loadDataRestaurants(),
          builder: (context, snapshoot) {
            RestaurantsResponse data = snapshoot.data;
            if (snapshoot.hasData) {
              return ListView.builder(
                padding: EdgeInsets.all(14),
                itemCount: data.restaurants.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: itemRestaurant(data.restaurants[index]),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/detailPage',
                        arguments: data.restaurants[index],
                      );
                    },
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
