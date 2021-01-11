import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/Restaurant.dart';
import 'package:restaurant_app/ui/detail/page/detail_page.dart';

class ItemRestaurant extends StatelessWidget {
  final Restaurant restaurant;
  ItemRestaurant({Key key, this.restaurant}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          DetailPage.routeName,
          arguments: restaurant.id,
        );
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Image.network(
                "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
                width: 130,
                height: 100,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 20.0, color: Colors.grey),
                      Text(restaurant.city),
                    ],
                  ),
                  SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.star,
                        size: 20.0,
                        color: Colors.yellow[700],
                      ),
                      Text(restaurant.rating.toString()),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}