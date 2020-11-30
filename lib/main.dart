import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/detail/page/detail_page.dart';

import 'ui/home/page/home_page.dart';

void main() {
  runApp(MyApp());
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
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/detailPage': (context) => DetailPage()
      },
    );
  }
}
