import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/Restaurant.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/home/widget/item_restaurant.dart';
import 'package:restaurant_app/ui/search/page/search_page.dart';

class HomePage extends StatelessWidget {
  static const routeName = "/home_page";

  @override
  Widget build(BuildContext context) {
    Provider.of<RestaurantProvider>(context, listen: false).fetchRestaurants();
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverAppBar(
              title: Text(isScrolled ? "Restaurant" : ""),
              elevation: 0,
              pinned: true,
              actions: [
                IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        SearchPage.routeName,
                      );
                    })
              ],
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
        body: Consumer<RestaurantProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.HasData) {
              return _buildList(state.restaurants.restaurants);
            } else if (state.state == ResultState.NoData) {
              return Center(child: Text(state.message));
            } else if (state.state == ResultState.Error) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      Provider.of<RestaurantProvider>(context, listen: false)
                          .fetchRestaurants();
                    },
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

class BuildList extends StatelessWidget {
  final List<Restaurant> restaurant;
  BuildList(this.restaurant);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

Widget _buildList(List<Restaurant> restaurant) {
  return ListView.builder(
    padding: EdgeInsets.all(14),
    itemCount: restaurant.length,
    itemBuilder: (context, index) {
      return GestureDetector(
        child: ItemRestaurant(
          restaurant: restaurant[index],
        ),
      );
    },
  );
}
