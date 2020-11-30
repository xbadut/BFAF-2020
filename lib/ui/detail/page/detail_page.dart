import 'package:flutter/material.dart';
import 'package:restaurant_app/model/Restaurant.dart';
import 'package:restaurant_app/ui/detail/widget/item_menu.dart';

const String FOODS = "foods";
const String DRINKS = "drinks";

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var menu;
  List<dynamic> menuList;
  @override
  Widget build(BuildContext context) {
    final Restaurant restaurant = ModalRoute.of(context).settings.arguments;
    if (menu == null || menu == FOODS) {
      menuList = restaurant.menus.foods;
      menu = FOODS;
    } else if (menu == DRINKS) {
      menuList = restaurant.menus.drinks;
    }
    return Scaffold(
      body: Container(
        child: NestedScrollView(
          headerSliverBuilder: (context, isScroll) {
            return [
              SliverAppBar(
                actions: [Icon(Icons.share)],
                elevation: 0,
                pinned: true,
                expandedHeight: 230,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    restaurant.pictureId,
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
                          setState(() {
                            menu = FOODS;
                          });
                        },
                      ),
                      SizedBox(width: 14),
                      GestureDetector(
                        child: itemMenu(context, DRINKS),
                        onTap: () {
                          setState(() {
                            menu = DRINKS;
                          });
                        },
                      ),
                    ],
                  ),
                  menuList != null
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: menuList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                                title: Text(menuList[index].name),
                                leading: menu == FOODS
                                    ? Icon(Icons.food_bank)
                                    : Icon(Icons.local_drink));
                          })
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
