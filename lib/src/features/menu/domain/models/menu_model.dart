

import 'package:catering_service_app/src/features/review/domain/review_model.dart';

class Menus {
  String userId;
  String menuId;
  String providerName;
  double price;
  String categoryId;
  String categoryName;
  String categoryImage;
  String menuDescription;
  List<String> starterMenu;
  List<String> mainCourseMenu;
  List<String> dessertMenu;
  List<ReviewModel>? reviews;

  Menus({
    required this.userId,
    required this.menuId,
    required this.providerName,
    required this.price,
    required this.categoryId,
    required this.categoryName,
    required this.categoryImage,
    required this.starterMenu,
    required this.mainCourseMenu,
    required this.dessertMenu,
    required this.menuDescription,
    this.reviews = const [],
  });

  factory Menus.fromJson(Map<String, dynamic> json) {
    return Menus(
      userId: json['userId'],
      menuId: json['menuId'],
      providerName: json['providerName'],
      price: double.tryParse(json['price'] ?? '') ?? 0.0,
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      categoryImage: json['categoryImage'],
      menuDescription: json['menuDescription'],
      starterMenu: List<String>.from(json['starterMenu']),
      mainCourseMenu: List<String>.from(json['mainCourseMenu']),
      dessertMenu: List<String>.from(json['dessertMenu']),
      reviews: json['reviews'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'providerName': providerName,
      'price': price,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'starterMenu': starterMenu,
      'mainCourseMenu': mainCourseMenu,
      'dessertMenu': dessertMenu,
    };
  }
}
