import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/Restaurant.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/home/widget/item_restaurant.dart';

class SearchPage extends StatefulWidget {
  static const routeName = "/searh_page";

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _query = TextEditingController();

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              title: Text(isScrolled ? "Search Restaurant" : ""),
              elevation: 0,
              pinned: true,
              expandedHeight: 160,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Search Restaurant",
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      Container(
                        child: TextField(
                          controller: _query,
                          decoration: new InputDecoration(
                              hintText: 'Restaurant mantap',
                              focusColor: Colors.white,
                              fillColor: Colors.white),
                          style: TextStyle(color: Colors.white),
                          onChanged: (v) async {
                            await Provider.of<RestaurantProvider>(context,
                                    listen: false)
                                .searhRestaurants(v);
                          },
                        ),
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
            if (state.stateSearch == ResultState.Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.stateSearch == ResultState.HasData) {
              return _buildList(state.restaurantsSearch.restaurants);
            } else if (state.stateSearch == ResultState.NoData) {
              return Center(child: Text(state.messageSearch));
            } else if (state.stateSearch == ResultState.Error) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      Provider.of<RestaurantProvider>(context,
                                    listen: false)
                                .searhRestaurants(_query.text);
                    },
                  ),
                ],
              );
            } else {
              return Center(child: Text("Silahkan search dengan kata kunci"));
            }
          },
        ),
      ),
    );
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
