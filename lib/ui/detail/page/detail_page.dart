import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/Restaurant.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/detail/widget/item_menu.dart';

const String FOODS = "foods";
const String DRINKS = "drinks";

class DetailPage extends StatelessWidget {
  static const routeName = '/detail_page';

  final String idRestaurant;
  DetailPage({@required this.idRestaurant});

  @override
  Widget build(BuildContext context) {
    Provider.of<RestaurantProvider>(context, listen: false)
        .fetchDetailRestaurants(idRestaurant);
    return Scaffold(
      body: Center(
        child: Consumer<RestaurantProvider>(
          builder: (BuildContext context, value, Widget child) {
            if (value.stateDetail == ResultState.Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (value.stateDetail == ResultState.HasData) {
              return Content(
                restaurant: value.restaurant,
                restaurantProvider: value,
              );
            } else if (value.stateDetail == ResultState.NoData) {
              return Center(child: Text(value.messageDetail));
            } else if (value.stateDetail == ResultState.Error) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(value.messageDetail),
                    IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: () {
                       Provider.of<RestaurantProvider>(context, listen: false)
          .fetchDetailRestaurants(idRestaurant);
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

class Content extends StatelessWidget {
  final Restaurant restaurant;
  final RestaurantProvider restaurantProvider;
  Content({Key key, this.restaurant, this.restaurantProvider});

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, isScroll) {
        return [
          SliverAppBar(
            actions: [Icon(Icons.share)],
            elevation: 0,
            pinned: true,
            expandedHeight: 230,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
                fit: BoxFit.fill,
              ),
            ),
          ),
        ];
      },
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                restaurant.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  Icon(Icons.location_on, size: 20.0, color: Colors.grey),
                  Text(restaurant.city),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                "Description",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                restaurant.description,
                style: TextStyle(
                  fontSize: 15,
                ),
                textAlign: TextAlign.justify,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                "Menu",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: itemMenu(context, FOODS),
                    onTap: () {
                      restaurantProvider.setMenu(FOODS);
                    },
                  ),
                  SizedBox(width: 14),
                  GestureDetector(
                    child: itemMenu(context, DRINKS),
                    onTap: () {
                      restaurantProvider.setMenu(DRINKS);
                    },
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: restaurantProvider.dataMenu.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      title: Text(restaurantProvider.dataMenu[index].name),
                      leading: Icon(Icons.food_bank));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
