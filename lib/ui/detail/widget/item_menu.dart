import 'package:flutter/material.dart';

Widget itemMenu(BuildContext context, var menu) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.orange[800]
    ),
    width: MediaQuery.of(context).size.width / 2.5,
    height: 74,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.food_bank,
          color: Colors.white,
          size: 40,
        ),
        Text(
          menu,
          style: TextStyle(color: Colors.white, fontSize: 22),
        )
      ],
    ),
  );
}
