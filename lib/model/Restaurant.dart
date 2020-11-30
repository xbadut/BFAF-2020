import 'menus.dart';

class Restaurant {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  dynamic rating;
  Menus menus;

  Restaurant(
      {this.id,
      this.name,
      this.description,
      this.pictureId,
      this.city,
      this.rating,
      this.menus});

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    pictureId = json['pictureId'];
    city = json['city'];
    rating = json['rating'];
    menus = json['menus'] != null ? new Menus.fromJson(json['menus']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['pictureId'] = this.pictureId;
    data['city'] = this.city;
    data['rating'] = this.rating;
    if (this.menus != null) {
      data['menus'] = this.menus.toJson();
    }
    return data;
  }
}
